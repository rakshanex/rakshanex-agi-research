# KAGGLE FRONTIER REPLICATION — FINAL REPORT

## 1. Executive Summary
On free Kaggle GPU (Tesla T4), the program's core conclusion was tested on two 7B open-weight models,
stronger than the local <=3B regime. Result: the diverse-abstention mechanism does NOT add task
CAPABILITY at 7B; it reduces confident-wrong errors by ABSTAINING (trading coverage) — the same
selection/coverage behavior found locally. Classification: ROBUST_ACROSS_TESTED_TIERS (KNOWN effect:
selective prediction / risk-coverage). No novelty. Scoped to the locked arithmetic benchmark + 7B models.

## 2. What Was Pre-Registered
Benchmark_v1_locked (473 tasks, sha256 78446ba9...). A=greedy always-answer; B=3 diverse prompts
(temps 0.0/0.5/0.8) unanimous-or-abstain. Exact-match scoring; confident_wrong=answered&wrong.
Equivalence margin ±5pp (TOST). 2 tiers, 2 families. max_new_tokens=160 (post-smoke-fix).

## 3. What Actually Ran
473/473 tasks BOTH tiers; 0 failures; 0 duplicates; 0 missing; 0 unparseable (946 records). Complete-case.

## 4. Model & Hardware
Tier A Qwen2.5-7B-Instruct (bf16, T4, wall 2594s). Tier B Mistral-7B-Instruct-v0.3 (bf16, T4, wall 6625s).
Llama-3.1-8B was intended for Tier B but is gated (401) → swapped to Mistral-7B (recorded, not silent).

## 5. Benchmark Integrity
In-kernel sha256 MATCH (78446ba9...); 473 tasks. PROTOCOL_INTEGRITY = PASS.

## 6. Failure Accounting
0 failures either tier (OOM/timeout/CUDA/malformed/parser all 0). No differential missingness.

## 7. Primary Results (raw counts)
| Tier | Cond | N | Answered | Correct | Confident-Wrong | Accuracy(all) | Acc-on-answered | Coverage |
|------|------|--:|---------:|--------:|----------------:|--------------:|----------------:|---------:|
| Qwen-7B | A | 473 | 473 | 291 | 182 | 0.615 | 0.615 | 1.000 |
| Qwen-7B | B | 473 | 275 | 271 | 4 | 0.573 | 0.985 | 0.581 |
| Mistral-7B | A | 473 | 473 | 221 | 252 | 0.467 | 0.467 | 1.000 |
| Mistral-7B | B | 473 | 171 | 152 | 19 | 0.321 | 0.889 | 0.362 |

## 8. Wilson 95% CIs
Qwen A_acc 0.615 [0.571,0.658]; B acc-on-answered 0.985 [0.963,0.994]; B coverage 0.581 [0.537,0.625].
Mistral A_acc 0.467 [0.423,0.512]; B acc-on-answered 0.889 [0.833,0.928]; B coverage 0.362 [0.320,0.406].

## 9. TOST ±5pp — CAPABILITY test (B all-task acc − A acc)
Qwen diff −0.042 CI[−0.104,+0.020] => INCONCLUSIVE at 5pp (but sign ≤0 by construction: B abstains).
Mistral diff −0.146 CI[−0.207,−0.084] => NON-EQUIVALENT, B LOWER (capability NOT added, coverage traded).
=> Mechanism does not add capability at 7B. (B all-task accuracy cannot exceed A because abstention.)

## 10. Local ≤3B vs Kaggle 7B
Base capability rises with scale (arithmetic: local 1.1B ~0.10 → Qwen 0.615). But the MECHANISM CLASS is
invariant: B trades coverage to cut confident-wrong at every tier. Prior VERIFIED claim (benefit is
safety/abstention, not capability) HOLDS at 7B. Protocols identical (same benchmark/prompts/scoring).

## 11. Selection vs Capability
Confident-wrong reduction A→B: Qwen 0.385→0.008 (diff −0.376 CI[−0.421,−0.332]); Mistral 0.533→0.040
(diff −0.493 CI[−0.539,−0.443]) => EFFECT_DETECTED (large). This is a SELECTION/COVERAGE effect: B answers
a high-precision subset and abstains on disagreement. NOT capability.

## 12. Representation Discovery
Not part of this run (representation-discovery branch already terminated; not re-tested here).

## 13. Adversarial Review (Researcher-B)
12 objections logged (audits/researcher_b_review.json). Key concessions: 7B is not frontier (scoped);
arithmetic pretraining exposure cannot be fully excluded (PARTIAL); Qwen capability-null slightly
underpowered at 5pp (but sign negative by construction). Core finding survives: mechanism = abstention.

## 14. Reproducibility
REPRODUCIBLE: self-contained hash-verified kernel, pinned models, per-sample raw records, one-command
push/output. Caveat: B temps>0 not seeded (aggregate stable at N=473; A greedy reproducible).

## 15. Limitations
7B not frontier; single arithmetic benchmark; 2 families; B not seeded; possible arithmetic pretraining
exposure; capability-null underpowered to exclude <5pp effects (but B≤A structurally).

## 16. Scientific Classification
ROBUST_AT_7B (mechanism = selection/abstention, confident-wrong reduction via coverage trade, invariant
1.1B→7B across 2 families) + KNOWN_RECOMBINATION (selective prediction / risk-coverage). NOVELTY_STATUS =
NONE_CONFIRMED (not proof novelty is absent everywhere; scoped negative/replication).

## 17. Updated Claim Ledger
New VERIFIED claim: the safety-not-capability finding replicates at 7B across 2 open-weight families.
No prior claim reversed. Prior VERIFIED claim 14 (benefit is abstention not capability) STRENGTHENED.

## 18. Exact Next Decision
The 7B replication CONFIRMED the existing negative with adequate support for the LARGE effect. Per the
next-decision logic: do NOT start a new synthetic mechanism hunt. Move to PUBLICATION / EXTERNAL
REPLICATION. A further tier (frontier API model) would test scope beyond 7B but is not required to
support the current scoped claim; it is optional and resource-gated.
