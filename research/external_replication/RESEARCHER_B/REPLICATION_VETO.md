# RESEARCHER-B REPLICATION VETO (15)
1 benchmark leakage PASS (hash-locked). 2 hidden dependency PASS (stdlib only R1-R3). 3 seed dependence PASS
(fixed; R2/R3 stable). 4 impl mismatch PASS (same runners). 5-6 model/prompt mismatch N/A for R1-R3 (no model).
7 truncation N/A (deterministic). 8 parsing PASS. 9 compute mismatch N/A (CPU). 10 candidate-gen mismatch PASS
(R1 frozen candidate set reused). 11 verifier mismatch PASS (exact). 12 selection-policy mismatch PASS
(policies in raw). 13 post-hoc tuning PASS (none). 14 result leakage PASS (guide gives NO expected numbers).
15 OPERATOR DEPENDENCE FAIL->CONCEDED: same operator => this is INTERNAL_CLEAN_ROOM, not external.
VERDICT: R1/R2/R3 are package-standalone reproducible with no leakage/tuning; but independence is NOT
satisfied (obj 15). External independent replication remains PENDING.
