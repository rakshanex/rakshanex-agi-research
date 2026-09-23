# Independent-Review Checklist
[x] Reproduce the benchmark? yes - sha256 in benchmark_v1_locked.json, checked by runner.
[x] Reproduce raw outputs? yes - deterministic experiments regenerate; API experiments use committed raw.
[x] Reproduce statistics? yes - runner recomputes selection acc + breaker cw from raw.
[x] Reproduce confidence intervals? yes - Wilson CIs from counts (STATISTICAL_SUMMARY.md, deterministic).
[x] Reproduce the conclusion? yes - EFFECT_DETECTED (selection/decorrelation), UNDERPOWERED (capability).
[!] Hidden dependencies? API-based experiments (SOTA/ADAPTIVE) are NOT bit-reproducible (hosted models,
    no seed) - flagged; core deterministic experiments have none.
