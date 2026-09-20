# ARC TRANSFER — FINAL REPORT (verified N=120)
Model: Qwen2.5-7B-Instruct (Kaggle T4). Benchmark: 120-task ARC subset (<=10x10 grids) from arc_full
training, sha256-locked (MATCH). Same A/B mechanism as the arithmetic 3-family study; scorer = exact grid match.
INTEGRITY: N=120, 0 failed, 0 duplicates, 0 missing/unparseable, subset hash verified.

RESULTS:
- A (baseline, always answer): accuracy 0.0 [0, 0.031]; confident-wrong 120/120 (100%).
- B (diverse-abstention): all-task acc 0.0; coverage 0.008 (~1/120 answered); confident-wrong 1 (0.8%).
- Paired: A-right->B-abstain=0, A-wrong->B-right=0 (no capability); McNemar n.s. (both solved-sets empty).

DETERMINATION: (B) SELECTION/ABSTENTION TRANSFER. On ARC (a genuinely different environment that 7B
cannot solve), the mechanism reduces confident-wrong from 100% to 0.8% ENTIRELY by abstaining (coverage
->0.008); ZERO capability gain (0 tasks solved by either condition). 

SCIENTIFIC READING: consistent with the arithmetic 3-family result. The diverse-abstention mechanism is a
SELECTIVE-PREDICTION operator; on hard out-of-competence tasks it abstains rather than emitting confident-
wrong answers. It does NOT confer ability to solve ARC. This is a boundary/transfer result for the
selection effect, NOT an ARC capability result. 7B ~0% on ARC is expected and NOT a claim about ARC difficulty beyond this subset.
LIMITATIONS: single model (Qwen-7B); 120-task subset (<=10x10 grids); arithmetic-style A/B ported to grids;
7B floor near 0% so the capability question is answered trivially (nothing to select among). Frontier ARC
systems use far more compute/test-time-training; NOT comparable.
