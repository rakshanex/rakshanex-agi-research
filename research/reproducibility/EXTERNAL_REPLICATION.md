# EXTERNAL_REPLICATION
QUESTION: does diverse-abstention add capability or only trade coverage, at 7B?
HYPOTHESIS: only selection (B_solved subset of A_solved).
BENCHMARK: benchmark_v1_locked.json (sha256 78446ba9...). MODELS: Qwen2.5-7B-Instruct, Mistral-7B-Instruct-v0.3.
COMMAND: push kaggle_frontier_replication/kernel_full via `kaggle kernels push`; retrieve completed.jsonl.
EXPECTED: A acc ~0.62 (Qwen)/~0.47 (Mistral); B confident_wrong near-zero via abstention; A-wrong->B-right ~ few.
STAT TEST: paired McNemar (A vs B all-task) + Wilson CIs + TOST(5pp). POSITIVE (B adds capability) would need
A-wrong->B-right >> A-right->B-abstain (NOT observed). NEGATIVE = selection-only (observed).
LIMITATIONS: 7B not frontier; arithmetic; B temps unseeded (aggregate stable). No author contact needed.
