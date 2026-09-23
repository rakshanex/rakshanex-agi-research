# FRONTIER EXPERIMENT PROTOCOL (Phase 9 - FROZEN, not yet run; needs ~Rs.2-5k)
QUESTION: does capability-invariance of mechanisms survive stronger models?
DESIGN: >=2 capability tiers x >=1-2 families. MECHANISMS: baseline, self-consistency, verifier-rerank,
selective-abstention. N: >=385/arm (power 0.8, alpha 0.05, detect 5pp at p~0.5). EQUIVALENCE MARGIN
delta=5pp; report via TOST -> {NO_EFFECT_DETECTED, UNDERPOWERED, EQUIVALENT, EFFECT_DETECTED}.
LOCK before run: task set, prompts, sampling (temp/top-p), scoring (exact-match grader), stopping rule
(fixed N, no optional stopping), predefined exclusions (malformed output -> excluded, logged as
resource-consumption not observation). RECORD: model/version/provider/context/tokens/latency/successful+
failed calls/cost/task_id/seed/raw_output. FALSIFICATION: a mechanism's answered-accuracy diff CI entirely
> +5pp (forced-answer + coverage-matched) at higher tier => capability-invariance falsified at scale.
COST EST: ~Rs.2000-5000 (2 tiers x ~400 tasks x few samples). DO NOT SPEND until protocol frozen (it is).
