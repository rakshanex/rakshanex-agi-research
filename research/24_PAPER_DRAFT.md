# 24_PAPER_DRAFT

## Candidate titles (conservative)
1. "A Pre-registered Causal Audit of Inference-Time and Representational Mechanisms for Compositional
   Generalization: Twelve Negative and Known-Effect Results at Small Scale"
2. "Separating Capability from Search, Selection, and Verification: An Empirical Audit in Small and
   Synthetic Regimes"
3. "When Reasoning Mechanisms Move the Operating Point but Not the Capability: A Reproducible Negative
   Synthesis"
4. "Capability Is Not Identifiable from Selective Metrics: A Twelve-Mission Reproducible Audit"
5. "A Reproducible Negative-Results Archive for ARC-style Compositional-Generalization Mechanisms"

## ABSTRACT (honest, scope-first)
We report a 12-mission, pre-registered, self-adversarial empirical program (44 recorded claims, 25
documented negative results, 20 experiments) investigating whether inference-time and representational
mechanisms increase underlying task CAPABILITY on ARC-style compositional generalization, as opposed to
changing how existing solutions are found, selected, verified, or evaluated. Working under strict
constraints (models <=~3B via API or 4-bit local; synthetic micro-worlds; CPU/2GB-GPU; deterministic
seeds), we applied a fixed protocol per mission: prior-art firewall, pre-registration, compute-matching,
causal ablation, and hostile adversarial review. Across all missions we did NOT detect a capability gain
attributable to the tested mechanism; measured positive effects were attributable to abstention (trading
coverage for lower confident-error), sample-efficiency, external tools, or search over an already-adequate
hypothesis space. A factorial experiment (search x information x verification, fixed hypothesis space)
reproduces the search-vs-capability confound (search recovery effect +0.69; information +0.14;
verification +0.04) and shows that underlying capability is not identifiable from observed selective
metrics in these settings. We reject a universal common-bottleneck hypothesis: the limiting factor was
regime-dependent. All findings reproduce or recontextualize KNOWN effects (selective prediction,
capability-vs-skill, benchmark identifiability, library-learning, verifier gap); we claim NO novel
mechanism. We emphasize "not detected at this scale/power", NOT "does not exist", and that 5/5
ARC-transfer gates were NOT justified. Contribution: a rigorously documented, reproducible NEGATIVE-RESULTS
and REPLICATION artifact, plus an explicit resource-gated roadmap for the questions that remain open.

## Structure (sections 1-18 per spec) — content pointers
Related Work: selective prediction, Chollet, NFL, DreamCoder/library-learning, IRL identifiability,
Twin(2608.14490), benchmark validity, test-time scaling. Experimental Philosophy: kill-your-own-hypothesis,
pre-reg, Researcher-B. Unified Causal Framework: Score=f(C,S,A,V,B,R,P,M,T,X,G,I); which manipulated per
mission. Results: mission-by-mission (Tables 1-4). Cross-Experiment Synthesis: capability-invariance
(KNOWN). Negative Results: failure taxonomy (Table 3). Identifiability Limits: C not recoverable from
selective metrics. ARC Transfer: NOT justified (5/5). Limitations: scale, power, synthetic, non-independent
missions. Reproducibility: seeds, hashes, commands (19_REPRODUCTION_GUIDE). Conclusion: strongest possible
NEGATIVE result; no novelty; resource-gated frontier plan.

## Contribution level (section 19): LEVEL 2 (negative experimental result) + LEVEL 3 (cross-experiment
empirical synthesis of KNOWN effects). NOT LEVEL 4+ (no new regularity/principle/theory).
