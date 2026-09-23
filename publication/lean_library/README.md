# RakshanexNumberTheory — machine-checked Lean 4 library
A single-file, self-contained (plain Lean 4 core, **no Mathlib**) elementary number-theory library.
**38 theorems, kernel-verified, 0 `sorry`/`admit`/`unsafe`.** Author: Piyush Kumar (RAKSHANEX TECHNOLOGIES). License: CC-BY-4.0.

## Use / verify
    lean RakshanexNumberTheory.lean        # compiles clean (exit 0)
    # or import into a Lean project and reuse the lemmas

## Contents (selected)
infinitude_of_primes · no_sqrt2_sol (√2 irrational, elementary) · euclid_lemma (p∣ab ⇒ p∣a∨p∣b) ·
sumOdd_eq_sq (Σodd=n²) · gauss_sum · nicomachus-style · dvd_pow_of_dvd · dvd_antisymm · gcd universal property ·
two_dvd_consecutive · parity lemmas · collatz_local_descent (∀k≥1: T³(4k+1)<4k+1, SCOPED — not global Collatz).

## Honesty
All are KNOWN theorems, here FORMALLY VERIFIED from first principles. No novel result claimed. Reusable as an
educational / verification reference. Independent rebuild: copy the file to any dir with Lean 4.34.0 and run `lean`.
