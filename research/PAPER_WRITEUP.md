# Selective Prediction and Capability Measurement in ARC-Style Reasoning
**RAKSHANEX — ARC Prize 2026 Paper Track.** Linked code submission: arc-prize-2026-arc-agi-2 (id 56298829, COMPLETE). Code (CC0): github.com/rakshanex/rakshanex-agi-research

## Abstract
We present a pre-registered, adversarially-audited program (62 recorded claims, 34 documented failures, 44 experiments) asking a single question: when an inference-time mechanism improves an ARC-style benchmark score, is it *capability*, or a change in the coverage/confident-error operating point? Across three open-weight families (Qwen2.5-7B, Mistral-7B, Phi-3.5-mini; N=473 each) and a 120-task ARC transfer subset, a diverse-prompt abstention mechanism reduces confident-wrong errors primarily by abstaining (reducing coverage), with **no net capability gain** (mechanism all-task accuracy ≤ baseline everywhere; Fig 1). We show a purported composition-depth "capability wall" is **search-limited**: it recovers fully as search depth increases at fixed capability (Fig 3). We show benchmark score is **not invariant** to construct-irrelevant presentation and evaluation-policy changes (selection policy alone moves accuracy ~60pp at fixed capability), while a capability-grounded symbolic solver is exactly invariant. Finally, an apparent ≤9B→14B parity "transition" **did not reproduce** under a fresh balanced forced-answer comparison (7B 0.80 ≈ 14B 0.825); a 14B model does genuinely recognize parity (held-out 100-task, even 0.92/odd 0.78, Fisher p=4.6e-13; Fig 2), but this is a narrow base-capability effect, not a mechanism and not general reasoning. **No novel capability mechanism was identified.** Contribution: a reproducible negative synthesis + benchmark-design lessons (evaluations must be answer-balanced; report under fixed policy + validated presentation + matched compute).

## 1. Introduction
Reported gains from inference-time methods are often ambiguous between genuine capability and operating-point shifts. We separate CAPABILITY from search, representation, elicitation, compute, verification, and answer-selection, using controlled interventions and a symbolic-solver invariance baseline.

## 2. Prior Work
Selective prediction (El-Yaniv & Wiener 2010); capability≠skill (Chollet 2019); DreamCoder/library learning (Ellis 2020); IRL non-identifiability (Russell 1998); goal misgeneralization; emergence-as-artifact (Schaeffer 2023); psychometric construct-irrelevant variance; LLM prompt/format sensitivity (Sclar 2023). All mechanisms here are KNOWN; we claim no novelty.

## 3. Methods
Pre-registered A/B: A = greedy always-answer; B = 3 diverse prompts, unanimous-or-abstain. Exact/numeric/grid scoring; confident-wrong = answered & incorrect. Wilson 95% CIs, paired McNemar, TOST(±5pp), Fisher exact. Locked benchmark (sha256 78446ba9…); open-weight models on free Kaggle T4/P100; one-command reproduction harness; CC0.

## 4. Results
**4.1 Three families (Fig 1).** Confident-wrong falls sharply (Qwen 182→4, Mistral 252→19, Phi 124→9) via abstention; B all-task accuracy ≤ A in all three → no net capability gain.
**4.2 ARC transfer (Qwen-7B, 120).** A 0/120; B abstains ~99% (coverage 0.008), confident-wrong 100%→0.8%, 0 solved — selection transfers, capability does not.
**4.3 Search-limited "wall" (Fig 3).** Composition-depth failure recovers fully as search depth rises (M4: 0.03→1.0) — the boundary is search, not capability.
**4.4 Evaluation (non)invariance.** A capability-grounded symbolic solver is exactly invariant (I_task=1.0) to construct-preserving presentation; but LLM eval score shifts ~60pp (selection policy) / ~18pp (elicitation) at fixed capability — construct-irrelevant variance exceeding the capability signal.
**4.5 Scale transition — corrected (Fig 2).** A fresh balanced forced-answer comparison shows 7B (0.80) ≈ 14B (0.825): the earlier large ≤9B→14B parity gap did NOT reproduce (it was benchmark/elicitation-confounded). 14B does recognize parity (held-out p=4.6e-13) — narrow base-capability, replicated, not general reasoning.

## 5. Limitations
Small/synthetic + arithmetic + small-grid ARC; ≤14B; single model for scale; parity likely pretrained; original 35-task wall remains confounded; independent external replication PENDING (package released, EXTERNAL_READY); frontier (>14B/closed) COMPUTE_BLOCKED.

## 6. Reproducibility
Deterministic core reproduces (reproduce_all.sh PASS); hashes; CC0; public repo + release; self-contained external-replication package (CPU-only, no-leak guide).

## 7. Conclusion
Inference-time mechanisms shift the operating point (selection/abstention/search), not capability, across three families + ARC; no novel capability mechanism identified. Benchmark scores are not invariant to construct-irrelevant conditions and can measure the evaluation setup rather than capability. Key lesson: answer-balance evaluations and report under fixed policy + validated presentation + matched compute.

## Figures
Fig 1 fig1_three_family.png · Fig 2 fig2_heldout_parity.png · Fig 3 fig3_search_confound.png (in repo /PAPER/figures).

## References
Chollet 2019 (1911.01547); Ellis 2020 (2306.07856); IRL identifiability (2106.03498); goal misgeneralization (2105.14111); Schaeffer 2023; Twin (2608.14490); ARC-AGI-2 (2505.11831).
