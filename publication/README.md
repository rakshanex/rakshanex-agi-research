# RAKSHANEX AGI Research — Publication Package (citable)
Author: Piyush Kumar (RAKSHANEX TECHNOLOGIES). License: CC-BY-4.0. Repo: github.com/rakshanex/rakshanex-agi-research

## Abstract (exact, non-hyped)
A preregistered, adversarially-audited program (90 experiments, 63 recorded claims, 34 preserved failures) showing
that inference-time mechanisms — selection, abstention, verification, search — substantially alter observed
ARC-style benchmark behaviour by shifting the coverage/confident-error OPERATING POINT, WITHOUT increasing underlying
candidate-generation capability. Reproduced across three open-weight families (Qwen2.5-7B, Mistral-7B, Phi-3.5-mini;
N=473 each) and a 120-task ARC transfer subset. A composition "capability wall" is shown search-limited; an apparent
≤9B→14B parity "transition" did NOT reproduce under a fresh balanced forced-answer comparison. Ships a machine-checked
Lean 4 corpus (10 elementary theorems, kernel-verified, no `sorry`, incl. a SCOPED Collatz-local descent lemma).

## What is claimed / NOT claimed
CLAIMED: operating-point ≠ capability (scoped); reproducible negative synthesis; benchmark-design lessons; a
machine-checked lemma corpus. NOT CLAIMED: novel theorem, solved open problem, new AGI mechanism, SOTA, independent
external replication (pending).

## Contents
- paper/         — manuscript (PDF + LaTeX + markdown)
- figures/       — 3 figures (regenerable from public data)
- lean_corpus/   — 10 Lean-verified theorems + verify_all.sh + CORPUS_MANIFEST
- reproducibility/ — benchmark (sha256 78446ba9, 473 tasks) + reproduce scripts + statistical summary
- audit/         — FINAL_FREEZE integrity audit (claim audit, Researcher-B veto, scientific position)
- CITATION.cff, zenodo_metadata.json

## Reproduce
bash reproducibility/reproduce_all.sh ; cd lean_corpus && bash verify_all.sh
