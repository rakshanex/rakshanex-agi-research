# EXPECTED_RESULTS (deterministic; reproduce_core.py checks these)
- benchmark_v1 sha256: MATCH
- inexpressive-vocab deltas (DISCOVERED-RAW_ONLY): adequate 0.0 | mild +0.056 | strong 0.0
- selection effect: S0 accuracy 0.398, S4 accuracy 1.000 (pooled N: S0=3000, S4=2863)
- breaker diverse ensemble confident_wrong = 0 (of 159); correlated = 165 (of 500)
Interpretation is in STATISTICAL_SUMMARY.md. Effects are: selection EFFECT_DETECTED; capability-nulls
UNDERPOWERED; decorrelation EFFECT_DETECTED (synthetic/1.1B scope).
