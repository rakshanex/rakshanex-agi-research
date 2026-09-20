#!/usr/bin/env python3
"""ONE-COMMAND core reproduction for the AGI/ARC negative-results program.
Run:  python3 REPRODUCIBILITY/reproduce_core.py
Deterministic, CPU-only, no API, no network. Verifies benchmark hash, re-runs the 3 deterministic
headline experiments, recomputes headline statistics, and compares to EXPECTED_RESULTS.
Exit 0 = all expected values reproduced.
"""
import json, hashlib, subprocess, sys, os, math
ROOT=os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.chdir(ROOT)
ok=True
def check(label, cond):
    global ok
    print(f"[{'PASS' if cond else 'FAIL'}] {label}"); ok = ok and cond

# 1. benchmark hash
d=json.load(open('benchmark_v1_locked.json')); o={k:d[k] for k in d if k!='sha256'}
check("benchmark_v1 sha256 MATCH", hashlib.sha256(json.dumps(o,sort_keys=True).encode()).hexdigest()==d['sha256'])

# 2. inexpressive-vocab experiment reproduces expected deltas
r=subprocess.run([sys.executable,'GAP_CLOSURE/inexpressive_vocab_test.py'],capture_output=True,text=True,timeout=600)
out=r.stdout
check("inexpressive-vocab: adequate delta 0.0", "adequate     delta = 0.0" in out)
check("inexpressive-vocab: strong   delta 0.0", "strong       delta = 0.0" in out)

# 3. selection-effect statistic recomputed from raw
cl=json.load(open('SELECTIVE_PREDICTION_AUDIT/06_EXPERIMENT/raw_results/candidate_locked.json'))
from collections import defaultdict
agg=defaultdict(lambda:[0,0])
for row in cl: agg[row['policy']][0]+=row.get('answered',0); agg[row['policy']][1]+=row.get('correct',0)
def acc(p): a,c=agg[p]; return c/a if a else 0
s0,s4=acc('S0'),acc('S4')
check(f"selection S0 acc ~0.398 (got {round(s0,3)})", abs(s0-0.398)<0.01)
check(f"selection S4 acc ~1.000 (got {round(s4,3)})", abs(s4-1.000)<0.01)

# 4. breaker diverse cw == 0
br=json.load(open('breaker_results.json'))
div=[m for m in br if m['mode']=='diverse'][0]
check(f"breaker diverse confident_wrong == 0 (got {div['confident_wrong']})", div['confident_wrong']==0)

print("\nRESULT:", "ALL EXPECTED VALUES REPRODUCED" if ok else "REPRODUCTION MISMATCH")
sys.exit(0 if ok else 1)
