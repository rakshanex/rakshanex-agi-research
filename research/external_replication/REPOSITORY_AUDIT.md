# REPOSITORY_AUDIT (clean clone)
URL: github.com/rakshanex/rakshanex-agi-research  COMMIT: 8afae3241ea0be3e396cfaa23ac8c103aa74d61c
RELEASE: negative-results-v1  DATE: 2026-09-21
PRESENT (public): research/ reports, runners (arc_transfer_runner.py, kaggle_frontier_runner.py,
reproduce_core.py), analysis summaries, PUBLIC_RELEASE_MANIFEST.
MISSING for external replication (BLOCKERS):
- benchmark_v1_locked.json (the locked benchmark) — NOT in public repo
- reproduce_all.sh — NOT in public repo
- R1 raw candidate_locked.json + selective-prediction runner — NOT public
- R2 failure_surface runner (search-boundary) — NOT public
- R3 stage1 invariance runner — NOT public
=> STATUS: PARTIALLY_REPRODUCIBLE. An external replicator currently CANNOT run R1/R2/R3 from the repo alone.
FIX (in-scope reproducibility improvement): the EXTERNAL_REPLICATION/ package below adds the missing
deterministic, public-safe artifacts (benchmark + runners + reproduce script) so R1/R2/R3 become externally
runnable CPU-only. No benchmark modification; exact copies + hashes.
