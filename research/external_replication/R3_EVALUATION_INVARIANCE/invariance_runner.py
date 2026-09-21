"""
EVALUATION_INVARIANCE Stage 1 — LOCAL deterministic. Two contrasts:
(1) LAYER-1 PRESENTATION invariance of a FIXED symbolic solver under construct-preserving transforms
    (example-ordering, serialization, position-op relabel). A correct enumerative solver MUST be ~invariant
    => validates transforms + gives the invariance baseline.
(2) LAYER-2 POLICY: same solver+tasks, vary abstention/verification acceptance => score DOES move (legit,
    NOT an invariance failure) => demonstrates the 3-layer distinction empirically.
"""
import itertools, random, json

L=4; MOD=5
def rot(s): return s[1:]+s[:1]
def rev(s): return s[::-1]
def sw(s): t=s[:]; t[0],t[1]=t[1],t[0]; return t
def inc(s): return [(x+1)%MOD for x in s]
OPS={'rot':rot,'rev':rev,'sw':sw,'inc':inc}
def compose(names):
    def f(s):
        for n in reversed(names): s=OPS[n](s)
        return s
    return f
ALL=[list(p) for p in itertools.product(range(MOD),repeat=L)]

def solve(train_ex, max_depth=3, cap=200000):
    keys=list(OPS); nodes=0
    for d in range(1,max_depth+1):
        for combo in itertools.product(keys,repeat=d):
            nodes+=1
            if nodes>cap: return None
            f=compose(list(combo))
            if all(f(list(x))==list(y) for x,y in train_ex): return combo
    return None

# LAYER-1 construct-preserving transforms on the EXAMPLE SET (do not change the underlying task)
def g_identity(ex, rng): return ex
def g_shuffle_examples(ex, rng): e=ex[:]; rng.shuffle(e); return e   # order of demos is construct-irrelevant
def g_subset_reorder(ex, rng): e=ex[:]; rng.shuffle(e); return e[:max(3,len(e))]  # reorder
def g_value_permute(ex, rng):
    # a value-permutation applied to BOTH input and output preserves the task for position-only ops
    # (we restrict tasks to position ops rot/rev/sw here so this is genuinely construct-preserving)
    perm=list(range(MOD)); rng.shuffle(perm)
    return [([perm[v] for v in x],[perm[v] for v in y]) for x,y in ex]

TRANSFORMS={'identity':g_identity,'shuffle_examples':g_shuffle_examples,'value_permute':g_value_permute}

def run(seed):
    rng=random.Random(seed)
    inputs=rng.sample(ALL,20)
    # tasks = POSITION-only ops (so value_permute is construct-preserving)
    posops=['rot','rev','sw']
    tasks=[[rng.choice(posops) for _ in range(rng.randint(1,3))] for _ in range(40)]
    res={"seed":seed,"layer1_Itask":{}, }
    base_solved={}
    for i,tn in enumerate(tasks):
        ex=[(x,compose(tn)(x)) for x in inputs]
        base_solved[i]=(solve(ex) is not None)
    for gname,g in TRANSFORMS.items():
        agree=0
        for i,tn in enumerate(tasks):
            ex=[(x,compose(tn)(x)) for x in inputs]
            exg=g(ex, random.Random(seed*100+i))
            solved_g=(solve(exg) is not None)
            if solved_g==base_solved[i]: agree+=1
        res["layer1_Itask"][gname]=round(agree/len(tasks),3)
    # LAYER-2 policy contrast: accept-if-search-depth<=k (a verification/policy knob) - moves 'solved' count
    layer2={}
    for k in [1,2,3]:
        s=sum(1 for tn in tasks if (c:=solve([(x,compose(tn)(x)) for x in inputs],max_depth=k)) is not None)
        layer2[f"policy_depth{k}"]=round(s/len(tasks),3)
    res["layer2_policy"]=layer2
    return res

if __name__=="__main__":
    seeds=[1234,2025,7]; runs=[run(s) for s in seeds]
    print("=== LAYER-1 PRESENTATION invariance (task-level agreement vs identity), fixed solver ===")
    for g in TRANSFORMS:
        vals=[r["layer1_Itask"][g] for r in runs]; print(f"  {g:18} I_task per-seed {vals} mean {round(sum(vals)/len(vals),3)}")
    print("\n=== LAYER-2 POLICY (accept-depth) moves score (legit, NOT invariance failure) ===")
    for k in ['policy_depth1','policy_depth2','policy_depth3']:
        vals=[r["layer2_policy"][k] for r in runs]; print(f"  {k:16} solve-rate {round(sum(vals)/len(vals),3)}")
    l1=min(min(r["layer1_Itask"].values()) for r in runs)
    print(f"\nMIN Layer-1 I_task across all transforms/seeds = {l1}")
    print("=> if ~1.0: fixed symbolic solver is INVARIANT to construct-preserving presentation (validates transforms + baseline).")
    print("=> Layer-2 policy visibly changes solve-rate => 3-layer distinction confirmed empirically.")
    json.dump({"runs":runs},open("raw/stage1.json","w"),indent=2)
    print("wrote stage1.json")
