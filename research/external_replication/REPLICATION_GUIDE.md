# REPLICATION_GUIDE (no result-leak; deterministic core, CPU-only, no API)
An independent researcher can reproduce R1/R2/R3 with ONLY this package + Python 3 (stdlib). No expected
numbers are given here (no-leak). You compute them and compare to your own run's internal consistency.
STEP 1 clone repo github.com/rakshanex/rakshanex-agi-research (commit 8afae32) for context/reports.
STEP 2 use THIS EXTERNAL_REPLICATION/ package (contains the deterministic artifacts missing from the repo).
STEP 3 verify benchmark: python3 -c "import json,hashlib;d=json.load(open('benchmark_v1_locked.json'));o={k:d[k] for k in d if k!='sha256'};print(hashlib.sha256(json.dumps(o,sort_keys=True).encode()).hexdigest()==d['sha256'])" -> expect True
STEP 4 fresh venv (optional; stdlib only, no deps needed for R1/R2/R3).
STEP 8 R1: cd R1_SELECTIVE_PREDICTION && python3 analyze_r1.py   (recomputes selective-prediction from raw)
STEP 9 R2: cd R2_SEARCH_BOUNDARY && python3 search_boundary_runner.py   (composition x search failure surface)
STEP 10 R3: cd R3_EVALUATION_INVARIANCE && python3 invariance_runner.py   (Layer-1 presentation invariance)
STEP 11 R4 (optional, GPU): kaggle_frontier_runner.py in the repo; needs open-weight model + GPU (Kaggle).
STEP 12 compare your outputs across seeds (R2/R3 deterministic; R1 exact from raw). Report per-claim status.
INTERPRET (no-leak): R1 expect a monotone selection effect (policy changes accuracy/coverage); R2 expect the
failure to depend on search depth; R3 expect the symbolic-solver invariance metric near its ceiling. Exact
values are intentionally NOT provided.
