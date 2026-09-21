# Outreach post (for ARC Discord / r/MachineLearning / reproducibility forums) — honest, no result-leak

**Title:** Independent replication wanted: a ~10-min CPU-only negative-results package (selective prediction vs capability)

Body:
I've released a small, self-contained, CPU-only reproduction package for a pre-registered negative-results
study on ARC-style reasoning: does an inference-time "diverse-abstention" mechanism add task *capability*,
or only change the coverage/confident-error operating point?

I'm looking for an **independent** run (I want to avoid grading my own homework). No GPU or API needed for
the core; Python stdlib only; runs in ~10 minutes.

- Repo: github.com/rakshanex/rakshanex-agi-research (commit 8afae32, CC0)
- Package: EXTERNAL_REPLICATION/ (benchmark + 3 deterministic runners R1/R2/R3 + guide)
- I have intentionally NOT posted the expected numbers, to keep your run unbiased.

If you run it: please report your raw outputs + your environment (INDEPENDENCE_ATTESTATION.json). Contradictions
and partial replications are equally welcome — the goal is honest validation, not confirming my result.
Thanks!

---
## Structural blindness (2026-09-22)
The original operator's results are preserved (unaltered) under `original_outputs/` — DO NOT open before running.
The replication path (R1/R2/R3 runners) ships with EMPTY output dirs; runners regenerate outputs locally.
The original evidence has NOT been deleted or altered (see original_outputs/manifests/EVIDENCE_HASHES.txt).
Note: R1 scores a locked candidate input (candidate_locked.json) which reveals the aggregate result if inspected;
for a fully blind R1, score independently from the benchmark. R2 and R3 are fully blind.
