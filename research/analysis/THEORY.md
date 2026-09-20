# THEORY (surviving result, formalized)
System: model M on task set T. Per task: A = greedy answer (always answer); B = k-sample unanimous-or-abstain.
Variables: C=capability (P[M solves task]); coverage cov=P[B answers]; confident_wrong cw=P[answer & wrong].
PROVEN (experimentally, 7B x2 families, N=473): B does not increase the set of solved tasks beyond A;
B_solved is approximately a SUBSET of A_solved (Qwen: A-right->B-abstain=26 vs A-wrong->B-right=6;
Mistral: 70 vs 2). => B = selection operator on A's outputs, reducing cw by lowering coverage.
FORMAL: acc_on_answered(B) >= acc(A) but acc_all(B) <= acc(A); Delta_capability ~ 0; Delta_selection > 0.
HYPOTHESIZED (not proven): behavior at frontier scale; behavior on non-arithmetic tasks.
CONTRADICTED: "mechanism adds capability" (all forms tested).
NOT IDENTIFIABLE: base capability C from score alone (selection/search/coverage confound).
Scope: arithmetic benchmark, <=7B open-weight. NOT an AGI theory.
