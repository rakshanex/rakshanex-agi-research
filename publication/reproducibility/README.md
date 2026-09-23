# Reproducibility Package — AGI/ARC Negative-Results Program
ONE COMMAND: `python3 REPRODUCIBILITY/reproduce_core.py`  (CPU-only, deterministic, no API, no network)
Verifies benchmark hash + re-runs 3 deterministic headline experiments + recomputes headline statistics
vs EXPECTED_RESULTS.md. Exit 0 = reproduced. Runtime: a few minutes on 8-core CPU.
ENVIRONMENT: Linux, Python 3.12, numpy/torch(CPU) optional (core needs only stdlib). See
PUBLICATION_AUDIT/20_ENVIRONMENT_FINGERPRINT.json.
CONTENTS: STATISTICAL_SUMMARY.md (all effect sizes+Wilson CIs+equivalence categories), reproduce_core.py,
EXPECTED_RESULTS.md, REVIEW_CHECKLIST.md, PAPER_SKELETON.md, FRONTIER_PROTOCOL.md.
REPLICATION STATUS: AUTHOR_REPRODUCED + FRESH_RUN_REPRODUCED (this environment). NOT yet
INDEPENDENT_REPRODUCTION (no external researcher has run it).
