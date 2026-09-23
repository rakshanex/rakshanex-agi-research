# LEAN CORPUS MANIFEST — machine-checked, plain Lean 4 core (no Mathlib), 0 sorry
Lean 4.34.0. Run: bash verify_all.sh  (compiles each + prints #print axioms).
| id | theorem | statement | axioms |
|----|---------|-----------|--------|
| T01 | infinitude_of_primes | ∀ N ∃ p, Prime p ∧ p>N (from first principles) | propext,choice,Quot.sound |
| T02 | no_sqrt2_sol | ∀a,b>0: a²≠2b² (√2 irrational, elementary) | propext,Quot.sound |
| T03 | sumOdd_eq_sq | Σ(2k-1)=n² | propext,Quot.sound |
| T04 | gauss_sum | 2·Σk=n(n+1) | propext,Quot.sound |
| T05 | iter_dbl_grows | n ≤ iter dbl k n | propext,Quot.sound |
| T06 | euclid_lemma | p prime, p∣ab ⇒ p∣a ∨ p∣b | propext,Quot.sound |
| T07 | two_dvd_consecutive (+gcd) | 2∣n(n+1); gcd universal property | propext,Quot.sound |
| T08 | collatz_local_descent | ∀k≥1: T³(4k+1)<4k+1 (SCOPED, not global Collatz) | propext,Quot.sound |
| (+) | nicomachus | Σk³=(Σk)² | propext,Quot.sound |
ALL: no sorry/admit/unsafe/custom-axiom. KNOWN theorems, FORMALLY_VERIFIED (not novel). Independent fresh-dir rebuild PASS.
