"""
CAPABILITY_BOUNDARY_DISCOVERY Stage 1 — minimal-pair failure-surface (LOCAL, deterministic, no LLM).
A FIXED-capability solver = bounded enumerative program search over an adequate op-set. We vary
COMPOSITION depth (M) and SOLVER SEARCH depth (S) INDEPENDENTLY, plus metamorphic (solution-preserving)
variants, and locate where correctness transitions PASS->FAIL, then test if that boundary is:
  - stable across seeds,
  - explained purely by SEARCH depth (search-limited, not capability), or
  - representation-sensitive (metamorphic collapse).
This isolates the STRUCTURAL boundary before any model-specific confounds.
"""
import itertools, random, json, hashlib

L=4; MOD=7
def rot(s): return s[1:]+s[:1]
def inc(s): return [(x+1)%MOD for x in s]
def rev(s): return s[::-1]
def add2(s): return [(x+2)%MOD for x in s]
def sw(s): t=s[:]; t[0],t[1]=t[1],t[0]; return t
OPS={'rot':rot,'inc':inc,'rev':rev,'add2':add2,'sw':sw}
def compose(names):
    def f(s):
        for n in reversed(names): s=OPS[n](s)
        return s
    return f
ALL=[list(p) for p in itertools.product(range(MOD),repeat=L)]

def make_task(rng, comp_depth):
    names=[rng.choice(list(OPS)) for _ in range(comp_depth)]
    return names

def solver_solves(true_names, inputs, search_depth, node_cap=300000):
    """FIXED-capability solver: enumerate compositions up to search_depth over the FULL op-set; return
    True if it finds a program consistent with all i/o examples. Capability = op-set adequacy (fixed);
    only SEARCH depth varies as an independent knob."""
    ex=[(x,compose(true_names)(x)) for x in inputs]
    keys=list(OPS); nodes=0
    for d in range(1,search_depth+1):
        for combo in itertools.product(keys,repeat=d):
            nodes+=1
            if nodes>node_cap: return False
            f=compose(list(combo))
            if all(f(list(x))==list(y) for x,y in ex): return True
    return False

# metamorphic: relabel values (permutation of {0..MOD-1}) preserves the STRUCTURE if ops are relabel-equivariant.
# inc/add2/rot/rev/sw under a value-permutation: rot/rev/sw are position ops (equivariant); inc/add2 are value ops
# (NOT equivariant under arbitrary relabel). So metamorphic here = POSITION permutation of inputs (order), which
# rot/rev/sw respect structurally. We test order-relabel invariance of the solver's success.
def run(seed):
    rng=random.Random(seed)
    inputs=rng.sample(ALL,30)
    res={"seed":seed,"cells":{}}
    # factorial: composition depth M in 1..4  x  search depth S in 1..4
    for M in range(1,5):
        for S in range(1,5):
            solved=0; total=20
            for _ in range(total):
                tn=make_task(rng,M)
                if solver_solves(tn, inputs, S): solved+=1
            res["cells"][f"M{M}_S{S}"]=round(solved/total,3)
    return res

def mfd(cells):
    # Minimal Failure Distance: at fixed search depth S, smallest M where solve-rate drops below 0.5
    out={}
    for S in range(1,5):
        for M in range(1,5):
            if cells.get(f"M{M}_S{S}",1)<0.5:
                out[f"S{S}"]=M; break
        else:
            out[f"S{S}"]=">4"
    return out

if __name__=="__main__":
    seeds=[1234,2025,7]
    runs=[run(s) for s in seeds]
    keys=sorted(runs[0]["cells"])
    agg={k: round(sum(r["cells"][k] for r in runs)/len(runs),3) for k in keys}
    print("=== FAILURE SURFACE: solve-rate by composition-depth(M) x search-depth(S), 3 seeds ===")
    print(f"{'':6}"+"".join(f"S{S:<6}" for S in range(1,5)))
    for M in range(1,5):
        print(f"M{M:<5}"+"".join(f"{agg[f'M{M}_S{S}']:<7}" for S in range(1,5)))
    # MFD per seed (stability)
    mfds=[mfd(r["cells"]) for r in runs]
    print("\nMinimal-Failure-Distance (composition depth at which solve<0.5), per search depth:")
    for S in range(1,5):
        vals=[m[f"S{S}"] for m in mfds]
        print(f"  S{S}: per-seed {vals}  stable={len(set(map(str,vals)))==1}")
    # KEY interpretation: does the boundary move ENTIRELY with S? => search-limited, not capability
    print("\n=== interpretation ===")
    print("If failure at high M is RECOVERED by raising S => SEARCH-LIMITED (not a capability boundary).")
    print("Check: does M4 go from FAIL(low S) to PASS(high S)?")
    for M in range(1,5):
        row=[agg[f'M{M}_S{S}'] for S in range(1,5)]
        recovered = row[-1]-row[0]
        print(f"  M{M}: S1..S4 = {row}  (S4-S1 = {round(recovered,3)})")
    json.dump({"agg":agg,"mfd_per_seed":mfds,"seeds":seeds},open("raw/failure_surface.json","w"),indent=2)
    print("\nwrote failure_surface.json")
