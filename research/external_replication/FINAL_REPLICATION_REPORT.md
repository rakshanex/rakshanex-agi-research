# FINAL_REPLICATION_REPORT
## 1. Scope: package + clean-room verification of R1 (selective prediction), R2 (search boundary), R3
(evaluation invariance). R4 (7B/14B) optional, compute-gated.
## 2. Independence: case B (same operator + clean package environment) => INTERNAL_CLEAN_ROOM. NOT external.
## 3. Environment: Linux, Python 3.12, CPU-only (MX350 unused), stdlib.
## 4. Protocol fidelity: EXACT except package-relative output paths (logged, no science change).
## 5. R1: standalone recompute from raw reproduced (selection effect present; S-policies change acc/coverage/cw). EXTERNAL-READY.
## 6. R2: standalone run reproduced composition-x-search failure surface; failure recovers with search depth. EXTERNAL-READY.
## 7. R3: standalone run reproduced Layer-1 presentation invariance at ceiling for the symbolic solver. EXTERNAL-READY.
## 8. R4: REPLICATION_BLOCKED_COMPUTE locally; runnable on free Kaggle (runner in repo).
## 9. Failures: R4 local compute block (logged). Public repo was missing benchmark+deterministic runners (fixed in package).
## 10. Researcher-B: R1/R2/R3 leakage/tuning-free; operator-dependence CONCEDED => internal only.
## 11. Claim-by-claim:
- R1 selective prediction: ORIGINAL=abstention lowers confident-wrong via coverage, no capability. REPL=reproduced (package-standalone, internal). STATUS: INTERNAL_EXACT; EXTERNAL-READY. Uncertainty: needs external operator.
- R2 search boundary: ORIGINAL=composition failure search-limited. REPL=reproduced. STATUS: INTERNAL_EXACT; EXTERNAL-READY.
- R3 invariance: ORIGINAL=symbolic solver invariant, LLM eval not. REPL=symbolic baseline reproduced. STATUS: INTERNAL_EXACT; EXTERNAL-READY (LLM side separate).
- R4 7B~=14B: ORIGINAL=transition NOT robust (7B~=14B). REPL=DEFERRED (compute). STATUS: BLOCKED (local).
## 12. FINAL STATUS: INTERNAL_ONLY (package now EXTERNAL-READY for R1/R2/R3; R4 compute-gated).
Overall: EXTERNAL_REPLICATION still PENDING (no independent operator has run it). The package removes the
prior artifact blockers so external replication is now POSSIBLE.
## Answers: 1 externally replicated? none yet (package ready). 2 internally reproduced? R1/R2/R3. 3 failed? none.
4 blocked? R4 local (compute). 5 downgraded? no (prior corrections stand). 6 new claims? none (no new branch).
7 published evidence supports ledger? YES for deterministic core; repo needed the added artifacts. 8 uncertainty?
independence (external operator) + R4 compute. 9 external replication complete? NO. 10 remain frozen? YES.
