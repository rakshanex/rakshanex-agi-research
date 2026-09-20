"""
arc_transfer_runner.py — Gap 3: does the selection/abstention mechanism transfer from arithmetic to ARC?
SAME mechanism as the 3-family study; only the domain (grid transforms) + scorer (exact grid match) change.
A = baseline: 1 greedy completion, always answer.
B = diverse-abstention: 3 diverse prompt framings, parse grids, unanimous-or-abstain (all 3 grids equal).
Scoring: exact grid equality to the test output. confident_wrong = answered & wrong.
LOCKED ARC subset embedded (deterministic selection) for power + reproducibility. Kaggle GPU, ungated model.
"""
import json, re, hashlib, os, time, traceback
BENCH=os.environ.get("ARC_BENCH","arc_subset.json")  # embedded subset {id, train:[{input,output}], test_in, test_out}
OUT=os.environ.get("OUT","/kaggle/working")
MODEL=os.environ.get("ARC_MODEL","Qwen/Qwen2.5-7B-Instruct")
SMOKE_N=int(os.environ.get("SMOKE_N","0"))

def grid_str(g): return "\n".join(" ".join(str(c) for c in row) for row in g)
def parse_grid(text):
    # extract the last contiguous block of digit-rows
    rows=[]
    for line in text.strip().splitlines():
        nums=re.findall(r"-?\d+", line)
        if nums and len(nums)>=1 and all(re.fullmatch(r"\d+",n) for n in nums):
            rows.append([int(n) for n in nums])
        elif rows:
            break  # stop at first non-grid line after grid started
    return rows if rows else None

def make_prompt(task, framing):
    ex="\n\n".join(f"Input:\n{grid_str(p['input'])}\nOutput:\n{grid_str(p['output'])}" for p in task['train'])
    ti=grid_str(task['test_in'])
    base=f"Here are input->output grid examples:\n\n{ex}\n\nNow the test input:\n{ti}\n\n"
    if framing==0: return base+"Output ONLY the output grid as rows of space-separated integers."
    if framing==1: return base+"Give the output grid. Rows of numbers only, no text."
    return base+"Test output grid:"

def gen(model, tok, prompt, temperature):
    import torch
    text=tok.apply_chat_template([{"role":"user","content":prompt}],add_generation_prompt=True,tokenize=False)
    enc=tok(text,return_tensors="pt").to(model.device); enc.pop("token_type_ids",None)
    gk=dict(max_new_tokens=400,pad_token_id=tok.eos_token_id)
    if temperature>0: gk.update(do_sample=True,temperature=temperature)
    else: gk.update(do_sample=False)
    out=model.generate(**enc,**gk)
    return tok.decode(out[0][enc["input_ids"].shape[1]:],skip_special_tokens=True)

def run():
    import torch
    from transformers import AutoModelForCausalLM, AutoTokenizer
    tasks=json.load(open(BENCH))
    if SMOKE_N: tasks=tasks[:SMOKE_N]
    ckpt=os.path.join(OUT,"arc_transfer"); os.makedirs(ckpt,exist_ok=True)
    done_path=os.path.join(ckpt,"completed.jsonl"); fail_path=os.path.join(ckpt,"failed.jsonl")
    done=set()
    if os.path.exists(done_path):
        for l in open(done_path):
            try: done.add(json.loads(l)["id"])
            except: pass
    tok=AutoTokenizer.from_pretrained(MODEL)
    model=AutoModelForCausalLM.from_pretrained(MODEL,torch_dtype=torch.bfloat16,device_map="auto")
    json.dump({"model":MODEL,"gpu":(torch.cuda.get_device_name(0) if torch.cuda.is_available() else "cpu"),
               "cuda":torch.cuda.is_available(),"n_tasks":len(tasks)},open(os.path.join(ckpt,"model_fingerprint.json"),"w"),indent=2)
    t0=time.time()
    with open(done_path,"a") as df, open(fail_path,"a") as ff:
        for t in tasks:
            if t["id"] in done: continue
            rec={"id":t["id"]}; gold=t["test_out"]
            try:
                a=parse_grid(gen(model,tok,make_prompt(t,2),0.0))
                rec["A_correct"]=(a==gold); rec["A_confident_wrong"]=(a is not None and a!=gold)
                bs=[parse_grid(gen(model,tok,make_prompt(t,i),temp)) for i,temp in enumerate([0.0,0.5,0.8])]
                uni = bs[0] is not None and bs[0]==bs[1]==bs[2]
                rec["B_answered"]=uni; rec["B_correct"]=(uni and bs[0]==gold); rec["B_confident_wrong"]=(uni and bs[0]!=gold)
                df.write(json.dumps(rec)+"\n"); df.flush()
            except Exception as e:
                ff.write(json.dumps({"id":t["id"],"error":type(e).__name__,"trace":traceback.format_exc()[:300]})+"\n"); ff.flush()
    json.dump({"model":MODEL,"n":len(tasks),"wall_s":round(time.time()-t0,1)},open(os.path.join(ckpt,"metadata.json"),"w"),indent=2)

if __name__=="__main__":
    run(); print("ARC transfer done")
