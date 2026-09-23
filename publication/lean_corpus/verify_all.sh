#!/bin/bash
# One-command verification of the entire machine-checked corpus (plain Lean 4 core, no Mathlib).
export PATH="$HOME/.elan/bin:$PATH"
declare -A T=(
 ["T01 primes"]="02_KNOWN_THEOREMS/T01_PRIMES/primes.lean:infinitude_of_primes"
 ["T02 sqrt2"]="02_KNOWN_THEOREMS/T02_SQRT2/sqrt2.lean:no_sqrt2_sol"
 ["T03 sumodd"]="02_KNOWN_THEOREMS/T03_NUMBER_THEORY/sumodd.lean:sumOdd_eq_sq"
 ["T04 gauss"]="02_KNOWN_THEOREMS/T04_COMBINATORICS/gauss.lean:gauss_sum"
 ["T05 iterate"]="02_KNOWN_THEOREMS/T05_DYNAMICS/iterate.lean:iter_dbl_grows"
 ["T06 euclid"]="02_KNOWN_THEOREMS/T06_EUCLID/euclid.lean:euclid_lemma"
 ["T07 gcd_parity"]="02_KNOWN_THEOREMS/T07_GCD_PARITY/gcd_parity.lean:two_dvd_consecutive"
 ["T08 divisibility"]="02_KNOWN_THEOREMS/T08_DIVISIBILITY/divisibility.lean:dvd_pow_of_dvd"
 ["T09 modular"]="02_KNOWN_THEOREMS/T09_MODULAR/modular.lean:mul_mod_residue"
 ["T08 collatz_local"]="05_COLLATZ/verified/local_descent.lean:collatz_local_descent"
)
for name in "${!T[@]}"; do
  src="${T[$name]%%:*}"; thm="${T[$name]##*:}"
  cp "$src" /tmp/_v.lean; echo "#print axioms $thm" >> /tmp/_v.lean
  out=$(lean /tmp/_v.lean 2>&1); ax=$(echo "$out"|grep 'depends on axioms'); err=$(echo "$out"|grep -c error)
  echo "$name: errors=$err | $ax"
done
