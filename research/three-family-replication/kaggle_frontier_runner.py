"""
kaggle_frontier_runner.py — protocol-preserving frontier replication (Kaggle GPU).
Tests whether the local <=3B negative/conditional conclusions survive a stronger open-weight model.

PROTOCOL (LOCKED, identical to local P5/candidate_locked; do NOT change):
  Benchmark: benchmark_v1_locked.json (473 tasks, sha256-verified at load).
  Condition A (baseline): 1 greedy sample, ALWAYS answer.
  Condition B (diverse-abstention): 3 diverse prompts, unanimous-or-abstain.
  Scoring: exact numeric match to gold. confident_wrong = answered & wrong.
  Metrics: coverage, accuracy-on-answered, confident_wrong_rate + per-sample forensic records.
Runs on 2 capability tiers (set MODELS). Full failure accounting; resume via checkpoints.
Meant for `kaggle kernels push` with benchmark_v1_locked.json attached as a dataset.
"""
import json, re, hashlib, os, time, traceback

BENCH_PATH = os.environ.get("BENCH","benchmark_v1_locked.json")
OUT = os.environ.get("OUT","/kaggle/working")
MODELS = [
    # (tier_label, hf_id)  -- Tier A stronger than local <=3B; Tier B stronger reasoning model
    ("tierA_qwen2.5-7b", "Qwen/Qwen2.5-7B-Instruct"),
    ("tierB_mistral-7b", "mistralai/Mistral-7B-Instruct-v0.3"),
]
DIVERSE = ["{q} Reply with ONLY the number.",
           "Solve: {q} Number only.",
           "Q: {q}\nFinal numeric answer:"]
SMOKE_N = int(os.environ.get("SMOKE_N","0"))  # >0 => only first N tasks (smoke test)

def num(t):
    m=re.findall(r"-?\d+", (t or "").replace(",",""))
    return int(m[-1]) if m else None

def load_bench():
    d=json.load(open(BENCH_PATH))
    o={k:d[k] for k in d if k!="sha256"}
    h=hashlib.sha256(json.dumps(o,sort_keys=True).encode()).hexdigest()
    assert h==d["sha256"], f"BENCHMARK HASH MISMATCH {h} != {d['sha256']}"
    tasks=d["tasks"]
    if SMOKE_N: tasks=tasks[:SMOKE_N]
    return tasks, d["sha256"]

def gen(model, tok, prompt, temperature):
    import torch
    msgs=[{"role":"user","content":prompt}]
    text=tok.apply_chat_template(msgs,add_generation_prompt=True,tokenize=False)
    enc=tok(text,return_tensors="pt").to(model.device)
    ids=enc["input_ids"]
    do_sample = temperature>0
    out=model.generate(**enc,max_new_tokens=160,do_sample=do_sample,
                        temperature=(temperature if do_sample else None),
                        pad_token_id=tok.eos_token_id)
    return tok.decode(out[0][ids.shape[1]:],skip_special_tokens=True)

def run_model(tier, hf_id, tasks, bench_hash):
    import torch
    from transformers import AutoModelForCausalLM, AutoTokenizer
    ckpt_dir=os.path.join(OUT,tier); os.makedirs(ckpt_dir,exist_ok=True)
    done_path=os.path.join(ckpt_dir,"completed.jsonl"); fail_path=os.path.join(ckpt_dir,"failed.jsonl")
    done_ids=set()
    if os.path.exists(done_path):
        for line in open(done_path): 
            try: done_ids.add(json.loads(line)["id"])
            except: pass
    t0=time.time()
    tok=AutoTokenizer.from_pretrained(hf_id)
    model=AutoModelForCausalLM.from_pretrained(hf_id,torch_dtype=torch.bfloat16,device_map="auto")
    fp={"tier":tier,"hf_id":hf_id,"dtype":"bfloat16","bench_sha256":bench_hash,
        "torch":torch.__version__,"cuda":torch.cuda.is_available(),
        "gpu":(torch.cuda.get_device_name(0) if torch.cuda.is_available() else "cpu")}
    json.dump(fp,open(os.path.join(ckpt_dir,"model_fingerprint.json"),"w"),indent=2)
    with open(done_path,"a") as df, open(fail_path,"a") as ff:
        for t in tasks:
            if t["id"] in done_ids: continue
            rec={"id":t["id"],"kind":t["kind"],"gold":t["gold"],"prompt_hash":hashlib.sha256(t["prompt"].encode()).hexdigest()[:16]}
            try:
                # A baseline: greedy, always answer
                a_raw=gen(model,tok,t["prompt"]+" Reply with ONLY the final number.",0.0); a_ans=num(a_raw)
                rec["A_raw"]=a_raw; rec["A_ans"]=a_ans
                rec["A_correct"]=(a_ans==t["gold"]); rec["A_confident_wrong"]=(a_ans is not None and a_ans!=t["gold"])
                # B diverse-abstention: 3 prompts temps 0.0/0.5/0.8, unanimous-or-abstain
                bs=[num(gen(model,tok,DIVERSE[i].format(q=t["prompt"]),temp)) for i,temp in enumerate([0.0,0.5,0.8])]
                rec["B_samples"]=bs
                unanimous = (len(set(bs))==1 and bs[0] is not None)
                rec["B_answered"]=unanimous
                rec["B_ans"]=bs[0] if unanimous else None
                rec["B_correct"]=(unanimous and bs[0]==t["gold"])
                rec["B_confident_wrong"]=(unanimous and bs[0]!=t["gold"])
                df.write(json.dumps(rec)+"\n"); df.flush()
            except Exception as e:
                ff.write(json.dumps({"id":t["id"],"error":type(e).__name__,"msg":str(e)[:200],
                                     "trace":traceback.format_exc()[:500]})+"\n"); ff.flush()
    meta={"tier":tier,"hf_id":hf_id,"n_tasks":len(tasks),"wall_sec":round(time.time()-t0,1),
          "bench_sha256":bench_hash}
    json.dump(meta,open(os.path.join(ckpt_dir,"metadata.json"),"w"),indent=2)
    return ckpt_dir

if __name__=="__main__":
    tasks,bench_hash=load_bench()
    print(f"loaded {len(tasks)} tasks, bench sha256 {bench_hash[:12]} (SMOKE_N={SMOKE_N})")
    for tier,hf in MODELS:
        print("=== running",tier,hf,"===")
        try: run_model(tier,hf,tasks,bench_hash)
        except Exception as e: print("MODEL BLOCKED:",tier,type(e).__name__,str(e)[:200])
    print("done. raw per-sample records in completed.jsonl per tier.")
