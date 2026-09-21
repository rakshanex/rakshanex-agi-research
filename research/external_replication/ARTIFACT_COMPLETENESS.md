# ARTIFACT_COMPLETENESS
R1 selective prediction: [x] raw candidate_locked [x] analysis script [x] scoring defs [x] protocol -> COMPLETE (package)
R2 search boundary: [x] generator+solver+runner [x] verifier(exact) [x] config(in-code) -> COMPLETE (package)
R3 evaluation invariance: [x] runner [x] transforms [x] verifier -> COMPLETE (package)
R4 model replication: [x] runner (repo) [ ] model weights (external: Kaggle official Qwen) [ ] GPU -> REPLICATION_BLOCKED_COMPUTE for local; runnable on free Kaggle
benchmark_v1_locked.json: [x] included + hash-verified.
NOTE: public REPO alone was missing benchmark + deterministic runners (see REPOSITORY_AUDIT); this package
supplies them so R1/R2/R3 are externally runnable. Recommend committing this package into the public repo.
