# README_REPLICATOR — Independent Reproduction / Falsification
## WHY THIS EXISTS
A research record claims a set of DETERMINISTIC results about selective prediction, search-limited failure, and
evaluation invariance. We are requesting genuinely independent reproduction OR falsification. Both outcomes are valuable.

## WHAT IS BEING TESTED (no expected numbers given)
- R1: a selective-prediction / policy effect on a locked benchmark.
- R2: how a failure surface behaves as search budget increases.
- R3: whether a capability-grounded symbolic solver's score is invariant to construct-preserving presentation.

## WHAT YOU NEED
Python 3 (standard library only). CPU. No GPU, no API, no payment, no private data, no internet for the runs.
Total runtime: a few minutes.

## WHAT YOU MUST NOT SEE BEFORE RUNNING
Do NOT open these until AFTER you produce your own outputs (they contain the original operator's results):
  research/external_replication/R1_SELECTIVE_PREDICTION/analysis/R1_ANALYSIS.json
  research/external_replication/R2_SEARCH_BOUNDARY/raw/failure_surface.json
  research/external_replication/R3_EVALUATION_INVARIANCE/raw/stage1.json
Run first; compare afterward.

## HOW TO CLONE + VERIFY COMMIT
  git clone https://github.com/rakshanex/rakshanex-agi-research
  cd rakshanex-agi-research
  git checkout 9fc26eb5d431c52a216bf08ebfd346f8bc0f1ab7
  git rev-parse HEAD    # must print 9fc26eb5d431c52a216bf08ebfd346f8bc0f1ab7

## HOW TO VERIFY BENCHMARK
  python3 -c "import json,hashlib;d=json.load(open('research/external_replication/benchmark_v1_locked.json'));o={k:d[k] for k in d if k!='sha256'};print(hashlib.sha256(json.dumps(o,sort_keys=True).encode()).hexdigest()==d['sha256'])"
  # must print True

## HOW TO RUN
  cd research/external_replication/R1_SELECTIVE_PREDICTION && python3 analyze_r1.py            # R1
  cd ../R2_SEARCH_BOUNDARY && python3 search_boundary_runner.py                                 # R2
  cd ../R3_EVALUATION_INVARIANCE && python3 invariance_runner.py                                # R3

## WHAT TO SAVE
Your regenerated analysis/raw JSON, console output, runtime, and your environment (OS/Python/CPU/RAM).

## HOW TO REPORT
Fill REPLICATION_ATTESTATION_TEMPLATE.md (pseudonymous OK), attach raw logs, and share back.
If you ask "what should I get?" the honest answer is: run first, compare afterward.
