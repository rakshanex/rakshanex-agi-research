# Independent Replication Protocol
This project has NO independent replication as of this release (status: NO_INDEPENDENT_OPERATOR).
Internal clean-room execution by the original author is NOT independent replication.

## What is being replicated (deterministic, CPU, Python stdlib)
- R1 (selective prediction): selection/policy changes observed behaviour on a locked candidate set.
- R2 (search boundary): a composition failure recovers as search budget increases.
- R3 (evaluation invariance): a capability-grounded symbolic solver is invariant to construct-preserving presentation.

## Exact target
- Repository commit: 68dc1b43a3fb9e9d7210a2b83bd765e7be89e6c5
- Benchmark: research/external_replication/benchmark_v1_locked.json
- Benchmark SHA256 prefix: 78446ba9 (473 tasks)

## Environment
Any CPU; Python 3; standard library only. No GPU, no API, no payment, no network for the runs.

## Reproduction commands
```
git clone https://github.com/rakshanex/rakshanex-agi-research && cd rakshanex-agi-research
git checkout 68dc1b43a3fb9e9d7210a2b83bd765e7be89e6c5
python3 -c "import json,hashlib;d=json.load(open('research/external_replication/benchmark_v1_locked.json'));o={k:d[k] for k in d if k!='sha256'};print(hashlib.sha256(json.dumps(o,sort_keys=True).encode()).hexdigest()==d['sha256'])"  # True
cd research/external_replication/R2_SEARCH_BOUNDARY && python3 search_boundary_runner.py     # save raw/failure_surface.json
cd ../R3_EVALUATION_INVARIANCE && python3 invariance_runner.py                                # save raw/stage1.json
cd ../R1_SELECTIVE_PREDICTION && python3 analyze_r1.py                                        # save analysis/R1_ANALYSIS.json
```

## Expected artifact structure
Each runner writes a JSON output to its own raw/ or analysis/ directory.

## Blind-run procedure & what you must NOT receive
Run all three BEFORE opening `original_outputs/` (original author results, preserved for post-run comparison).
You must NOT receive: expected numbers, author interpretation, or hidden correctness labels before running.
R2/R3 output dirs ship empty (blind). R1 reads candidate_locked.json (its input) which can reveal the aggregate
result if inspected first — treat R1 as partial-by-design; run before comparing.

## Acceptance criteria (pre-registered, deterministic)
- R2/R3/R1 are deterministic: EXACT = identical output values on the same commit+benchmark.
- Any deviation on identical commit+benchmark => SCIENTIFIC_DISCREPANCY (see triage below).

## Recording deviations / reporting failure
Fill ATTESTATION_TEMPLATE.md; attach raw logs + environment. Classify failures:
R1 code / R2 environment / R3 documentation / R4 data / R5 randomness / R6 compute / R7 scientific discrepancy / R8 unknown.
Do NOT report a technical failure (R1–R6) as scientific falsification.
