# RAKSHANEX — AGI / ARC Research

This repository (formerly `arc-prize-2026`) contains RAKSHANEX's ARC-AGI and AGI research. It is
organized into three clearly distinct work streams:

## 1. ARC-Prize 2026 submission (original)
The ARC Prize 2026 Paper-Prize material: `ARC_PRIZE_2026_PAPER.md`, `arc_prize_submission.py`,
`kaggle_notebook_RAKSHANEX.py`, learning foundations, and positioning docs. Preserved unchanged.

## 2. AGI research (learning + planning)
`AGI_LEARNING_FOUNDATIONS.md`, `10_YEAR_AGI_PLAN.md`, `LEARN_LEVEL_*` — study/roadmap material.

## 3. Negative-results & replication research (`research/`)
A pre-registered, adversarially-audited empirical program investigating whether inference-time
mechanisms (self-consistency, diverse-abstention, selective prediction) add underlying task CAPABILITY,
or only change the operating point (coverage/confident-error).

### What the evidence shows (scope-bound, conservative)
- Across **three open-weight model families** (Qwen2.5-7B, Mistral-7B, Phi-3.5-mini) on a locked
  473-task arithmetic benchmark, and on a **120-task ARC transfer subset** (Qwen2.5-7B), a
  diverse-prompt **abstention** mechanism reduces confident-wrong errors — but does so by **abstaining
  (reducing coverage)**, with **no demonstrated net capability gain**.
- On ARC (which the 7B model solves at ~0% here), the mechanism abstains on ~99% of tasks: confident-wrong
  falls from 100% to 0.8%, and **zero** tasks are newly solved. This is a **selective-prediction /
  abstention** effect, consistent across all tested settings.
- Paired analysis (McNemar) + Wilson confidence intervals + TOST (±5pp) support this. Full statistics in
  `research/analysis/`.

### What is NOT claimed
This work does **not** claim AGI, SOTA, an ARC breakthrough, a novel capability mechanism, or frontier
validation. **No novel capability mechanism was identified.** All findings reproduce or recontextualize
known effects (selective prediction; capability ≠ skill). See `research/analysis/NOVELTY_LEDGER.json`.

### Status
- Independent external replication: **not yet performed** (reproduction package in `research/reproducibility/`).
- Frontier closed-model validation: **resource-gated** (tested up to 7–9B open-weight only).
- Reproducibility: deterministic core experiments; `research/reproducibility/reproduce_core.py`.

### Limitations
Small/synthetic + arithmetic benchmark; ARC subset is ≤10×10 grids; ≤9B models; ARC 7B floor ~0% makes
the capability question trivially answered on that subset; not comparable to frontier ARC systems.

See `research/PUBLIC_RELEASE_MANIFEST.json` for the file inventory + SHA256 hashes.
