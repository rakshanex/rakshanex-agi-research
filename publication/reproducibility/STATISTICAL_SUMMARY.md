# STATISTICAL_SUMMARY (publication-grade) — Phase 2/3

## Equivalence categories used (Phase-3 discipline; margin delta = 5pp unless noted)
EFFECT_DETECTED | UNDERPOWERED | EQUIVALENT (TOST within delta) | NO_EFFECT_DETECTED | UNIDENTIFIABLE.
Rule: overlapping CIs are NEVER used as proof of equivalence.

## Result 1 — SELECTION EFFECT (strongest; candidate_locked, SELECTIVE_PREDICTION_AUDIT)
Unit: task-instances pooled over 3 seeds x caps per policy (pseudoreplication note: the sampling unit is
task-instances, NOT independent studies; CIs are proportion CIs, valid for that unit).
| policy | answered | accuracy | 95% Wilson CI | cw_rate | coverage(vs S0) | category |
|--------|---------:|---------:|---------------|--------:|----------------:|----------|
| S0 | 3000 | 0.398 | [0.380,0.415] | 0.602 | 1.000 | baseline |
| S1 | 2505 | 0.634 | [0.615,0.653] | 0.366 | 0.835 | EFFECT_DETECTED |
| S2 |  934 | 0.874 | [0.851,0.893] | 0.126 | 0.311 | EFFECT_DETECTED (abstention: low coverage) |
| S3 | 2975 | 0.821 | [0.807,0.835] | 0.179 | 0.992 | EFFECT_DETECTED |
| S4 | 2863 | 1.000 | [0.999,1.000] | 0.000 | 0.954 | EFFECT_DETECTED (verification policy) |
S0->S4 accuracy diff -0.602, 95% CI [-0.619,-0.584] => EFFECT_DETECTED, robust.
WHAT IT ESTABLISHES: answer-SELECTION/VERIFICATION policy strongly moves answered-accuracy and confident-
wrong. S2 buys accuracy by ABSTAINING (coverage 0.311); S4 by VERIFICATION (coverage 0.954, cw 0).
WHAT IT DOES NOT ESTABLISH: any increase in underlying CAPABILITY. Accuracy is on the SELECTED/answered
subset; the risk-coverage tradeoff is explicit. NOT an intelligence/capability claim.

## Result 2 — CAPABILITY-INVARIANCE NULLS (mechanisms don't add accuracy)
Category: UNDERPOWERED (NOT equivalence). E.g. SOTA arithmetic method diffs at N=3-30 have CIs spanning
the +-5pp margin many times over (M6 acc 0.0 CI [0,0.562] at N=3). Honest label: "no capability gain
DETECTED at this power", never "proven absent".

## Result 3 — DIVERSE vs CORRELATED ensemble (breaker, real 1.1B)
correlated cw 165/500 = 0.330 CI [0.290,0.372]; diverse cw 0/159 = 0.000 CI [0.000,0.024].
diff CI excludes 0 => EFFECT_DETECTED (decorrelation lowers confident-wrong), scope: synthetic/proxy + 1.1B.

## Result 4 — REPRESENTATION DISCOVERY (inexpressive-vocab)
DISCOVERED-RAW_ONLY delta {0, +0.056, 0}; at N=36/cell the diff CI ~[-0.184,+0.184] >> delta =>
UNDERPOWERED for equivalence. Branch terminated on MECHANISTIC grounds (discovery recombines, cannot
invent out-of-closure primitives; ORACLE=1.0), NOT statistical equivalence. Category: UNDERPOWERED + KNOWN.

## Global statistical caveats (must appear in paper)
Small N for most arms; missions NOT independent (shared benchmark/agent => ~3-4 independent questions,
not 24); no alpha correction across many hypotheses; API experiments not bit-reproducible. => the LARGE
effects (selection, decorrelation) are solid; the capability-nulls are power-limited.
