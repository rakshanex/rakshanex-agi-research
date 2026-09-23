-- RakshanexNumberTheory — machine-checked (Lean 4 core, no Mathlib) elementary number-theory library.
-- Kernel-verified theorems, no sorry/admit/unsafe. Author: Piyush Kumar / RAKSHANEX TECHNOLOGIES. License: CC-BY-4.0.
-- Verify: lean RakshanexNumberTheory.lean
open Classical


-- ===== primes.lean =====
-- T01: Infinitude of primes, plain Lean 4 core (no Mathlib).
def Prime (p : Nat) : Prop := 2 ≤ p ∧ ∀ m, m ∣ p → m = 1 ∨ m = p

def fact : Nat → Nat
  | 0 => 1
  | n+1 => (n+1) * fact n

theorem fact_pos : ∀ n, 1 ≤ fact n := by
  intro n; induction n with
  | zero => decide
  | succ k ih => simp [fact]; exact Nat.le_trans ih (Nat.le_mul_of_pos_left _ (by omega))

theorem dvd_fact : ∀ n p, 1 ≤ p → p ≤ n → p ∣ fact n := by
  intro n
  induction n with
  | zero => intro p h1 h2; omega
  | succ k ih =>
    intro p h1 h2
    rcases Nat.lt_or_ge p (k+1) with h | h
    · have hpk : p ≤ k := by omega
      obtain ⟨c, hc⟩ := ih p h1 hpk
      exact ⟨(k+1)*c, by rw [fact, hc, Nat.mul_left_comm]⟩
    · have hpe : p = k+1 := by omega
      exact ⟨fact k, by rw [hpe, fact]⟩

theorem exists_prime_factor : ∀ n, 2 ≤ n → ∃ p, Prime p ∧ p ∣ n := by
  intro n
  induction n using Nat.strongRecOn with
  | _ n ih =>
    intro hn
    by_cases hp : ∀ m, m ∣ n → m = 1 ∨ m = n
    · exact ⟨n, ⟨hn, hp⟩, Nat.dvd_refl n⟩
    · have hp2 : ∃ m, m ∣ n ∧ m ≠ 1 ∧ m ≠ n := by
        apply Classical.byContradiction
        intro hc
        apply hp
        intro m hm
        by_cases e1 : m = 1
        · exact Or.inl e1
        · by_cases e2 : m = n
          · exact Or.inr e2
          · exact absurd ⟨m, hm, e1, e2⟩ hc
      obtain ⟨m, hmdvd, hm1, hmn⟩ := hp2
      have hn0 : n ≠ 0 := by omega
      have hm0 : m ≠ 0 := by
        intro h; rw [h] at hmdvd; exact hn0 (Nat.eq_zero_of_zero_dvd hmdvd)
      have hm2 : 2 ≤ m := by
        rcases Nat.lt_or_ge m 2 with h | h
        · omega
        · exact h
      have hmle : m ≤ n := Nat.le_of_dvd (by omega) hmdvd
      have hmlt : m < n := Nat.lt_of_le_of_ne hmle hmn
      obtain ⟨p, hpp, hpm⟩ := ih m hmlt hm2
      exact ⟨p, hpp, Nat.dvd_trans hpm hmdvd⟩

theorem infinitude_of_primes : ∀ N, ∃ p, Prime p ∧ p > N := by
  intro N
  have hM2 : 2 ≤ fact N + 1 := by have := fact_pos N; omega
  obtain ⟨p, hpp, hpM⟩ := exists_prime_factor (fact N + 1) hM2
  refine ⟨p, hpp, ?_⟩
  rcases Nat.lt_or_ge N p with h | h
  · exact h
  · exfalso
    have hp1 : 1 ≤ p := by have := hpp.1; omega
    have hpfac : p ∣ fact N := dvd_fact N p hp1 h
    have hp1' : p ∣ 1 := (Nat.dvd_add_right hpfac).mp hpM
    have hple : p ≤ 1 := Nat.le_of_dvd (by omega) hp1'
    have := hpp.1
    omega

-- ===== sqrt2.lean =====
-- T02: elementary Diophantine irrationality of sqrt 2 (core Lean 4, no Mathlib).
-- Theorem: no positive a,b with a*a = 2*(b*b). (=> sqrt 2 irrational, elementary form.)

theorem even_of_sq_even (n : Nat) (h : 2 ∣ n*n) : 2 ∣ n := by
  rcases Nat.mod_two_eq_zero_or_one n with h0 | h1
  · exact Nat.dvd_of_mod_eq_zero h0
  · exfalso
    obtain ⟨c, hc⟩ := h
    obtain ⟨q, hq⟩ : ∃ q, n = 2*q+1 := ⟨n/2, by omega⟩
    have hnn : n*n = 4*(q*q) + 4*q + 1 := by
      subst hq
      have e : (2*q+1)*(2*q+1) = 4*(q*q)+4*q+1 := by
        simp [Nat.mul_add, Nat.add_mul, Nat.mul_comm, Nat.mul_assoc, Nat.mul_left_comm]
        omega
      exact e
    omega

theorem no_sqrt2_sol : ∀ a, 0 < a → ∀ b, 0 < b → a*a ≠ 2*(b*b) := by
  intro a
  induction a using Nat.strongRecOn with
  | _ a ih =>
    intro ha b hb heq
    have h2aa : 2 ∣ a*a := ⟨b*b, heq⟩
    have h2a : 2 ∣ a := even_of_sq_even a h2aa
    obtain ⟨k, hk⟩ := h2a
    have hk0 : 0 < k := by omega
    have haa : a*a = 4*(k*k) := by
      subst hk
      have e : (2*k)*(2*k) = 4*(k*k) := by
        simp [Nat.mul_comm, Nat.mul_assoc, Nat.mul_left_comm]
      exact e
    have hb2 : b*b = 2*(k*k) := by
      have h4 : 4*(k*k) = 2*(b*b) := by rw [← haa]; exact heq
      omega
    have hkk : 0 < k*k := Nat.mul_pos hk0 hk0
    have hblt : b < a := by
      rcases Nat.lt_or_ge b a with h | h
      · exact h
      · exfalso
        have hmm : a*a ≤ b*b := Nat.mul_le_mul h h
        omega
    exact ih b hblt hb k hk0 hb2

-- ===== sumodd.lean =====
-- T03: Number theory (distinct from T01) — sum of first n odd numbers = n^2.
-- sumOdd n = 1 + 3 + 5 + ... + (2n-1)
def sumOdd : Nat → Nat
  | 0 => 0
  | n+1 => sumOdd n + (2*n+1)

theorem sumOdd_eq_sq : ∀ n, sumOdd n = n*n := by
  intro n
  induction n with
  | zero => rfl
  | succ k ih =>
    show sumOdd k + (2*k+1) = (k+1)*(k+1)
    rw [ih]
    have : (k+1)*(k+1) = k*k + (2*k+1) := by
      simp [Nat.mul_add, Nat.add_mul, Nat.mul_comm]
      omega
    omega

-- ===== gauss.lean =====
-- T04: Finite combinatorics / counting — Gauss sum: 2 * (0+1+...+n) = n*(n+1).
-- (Stated multiplied out to avoid division; a finite counting identity, distinct proof style.)
def gsum : Nat → Nat
  | 0 => 0
  | n+1 => gsum n + (n+1)

theorem gauss_sum : ∀ n, 2 * gsum n = n * (n+1) := by
  intro n
  induction n with
  | zero => rfl
  | succ k ih =>
    show 2 * (gsum k + (k+1)) = (k+1)*(k+2)
    have hexp : 2 * (gsum k + (k+1)) = 2 * gsum k + 2*(k+1) := by
      simp [Nat.mul_add]
    rw [hexp, ih]
    have hkey : (k+1)*(k+2) = k*(k+1) + 2*(k+1) := by
      simp [Nat.mul_add, Nat.add_mul, Nat.mul_comm]
    omega

-- ===== iterate.lean =====
-- T05: Dynamics / iteration — reasoning about repeated function application.
-- Define iterate; prove iterating the doubling map k times on 1 yields 2^k (monotone growth theorem).
def iter (f : Nat → Nat) : Nat → Nat → Nat
  | 0,     x => x
  | (k+1), x => f (iter f k x)

def dbl (n : Nat) : Nat := 2 * n

-- pow2 defined locally
def pow2 : Nat → Nat
  | 0 => 1
  | k+1 => 2 * pow2 k

theorem iter_dbl_one : ∀ k, iter dbl k 1 = pow2 k := by
  intro k
  induction k with
  | zero => rfl
  | succ m ih =>
    show dbl (iter dbl m 1) = 2 * pow2 m
    rw [ih]
    rfl

-- iteration strictly increases a positive start under dbl (a descent/growth dynamical lemma)
theorem iter_dbl_grows : ∀ k n, 0 < n → n ≤ iter dbl k n := by
  intro k
  induction k with
  | zero => intro n hn; exact Nat.le_refl n
  | succ m ih =>
    intro n hn
    show n ≤ dbl (iter dbl m n)
    have h1 : n ≤ iter dbl m n := ih n hn
    have h2 : iter dbl m n ≤ dbl (iter dbl m n) := by
      show iter dbl m n ≤ 2 * iter dbl m n
      omega
    exact Nat.le_trans h1 h2

-- ===== euclid.lean =====
-- T06: Euclid's Lemma from first principles (own Prime def + core Nat.Coprime machinery).
-- p prime, p ∣ a*b  =>  p ∣ a  ∨  p ∣ b.   Core Lean 4, no Mathlib.
-- If p is prime and p does not divide a, then gcd(p,a) = 1 (i.e. Coprime p a).
theorem prime_coprime_of_not_dvd (p a : Nat) (hp : Prime p) (hna : ¬ p ∣ a) : Nat.Coprime p a := by
  -- g := gcd p a divides p, so g = 1 or g = p (primality). If g = p then p ∣ a (since g ∣ a), contradiction.
  have hg : Nat.gcd p a ∣ p := Nat.gcd_dvd_left p a
  rcases hp.2 (Nat.gcd p a) hg with h1 | hpe
  · exact h1
  · exfalso
    have hga : Nat.gcd p a ∣ a := Nat.gcd_dvd_right p a
    rw [hpe] at hga
    exact hna hga

-- Euclid's lemma.
theorem euclid_lemma (p a b : Nat) (hp : Prime p) (hdvd : p ∣ a * b) : p ∣ a ∨ p ∣ b := by
  by_cases ha : p ∣ a
  · exact Or.inl ha
  · -- p ∤ a  =>  Coprime p a  =>  from p ∣ a*b conclude p ∣ b
    have hcop : Nat.Coprime p a := prime_coprime_of_not_dvd p a hp ha
    exact Or.inr (Nat.Coprime.dvd_of_dvd_mul_left hcop hdvd)

-- ===== gcd_parity.lean =====
-- T07: more from-first-principles number theory (core Lean 4, no Mathlib).

-- (a) product of consecutive integers is even: 2 ∣ n*(n+1).
theorem two_dvd_consecutive (n : Nat) : 2 ∣ n * (n + 1) := by
  rcases Nat.mod_two_eq_zero_or_one n with h | h
  · obtain ⟨k, hk⟩ : ∃ k, n = 2*k := ⟨n/2, by omega⟩
    exact ⟨k*(n+1), by rw [hk, Nat.mul_assoc]⟩
  · obtain ⟨k, hk⟩ : ∃ k, n+1 = 2*k := ⟨(n+1)/2, by omega⟩
    refine ⟨k*n, ?_⟩
    rw [Nat.mul_comm n (n+1), hk, Nat.mul_assoc]

-- (b) gcd is a common divisor (both directions), from core.
theorem gcd_common_divisor (a b : Nat) : Nat.gcd a b ∣ a ∧ Nat.gcd a b ∣ b :=
  ⟨Nat.gcd_dvd_left a b, Nat.gcd_dvd_right a b⟩

-- (c) any common divisor divides the gcd (universal property).
theorem dvd_gcd_of_dvd_both (a b d : Nat) (ha : d ∣ a) (hb : d ∣ b) : d ∣ Nat.gcd a b :=
  Nat.dvd_gcd ha hb

-- ===== divisibility.lean =====
-- T08: divisibility theorems from first principles (core Lean 4, no Mathlib).

theorem dvd_add_of_dvd (d a b : Nat) (ha : d ∣ a) (hb : d ∣ b) : d ∣ a + b :=
  Nat.dvd_add ha hb

-- helper: a ∣ x  ⟹  a ∣ x * b   (explicit witness, core)
theorem dvd_mul_right_of_dvd (a x b : Nat) (h : a ∣ x) : a ∣ x * b := by
  obtain ⟨c, hc⟩ := h
  exact ⟨c * b, by rw [hc]; ac_rfl⟩

-- if a ∣ b then a ∣ b^(n+1) for all n (divisibility persists under powers).
theorem dvd_pow_of_dvd (a b : Nat) (h : a ∣ b) : ∀ n, a ∣ b ^ (n + 1) := by
  intro n
  induction n with
  | zero => simpa using h
  | succ k ih =>
    rw [Nat.pow_succ]
    exact dvd_mul_right_of_dvd a (b ^ (k + 1)) b ih

theorem dvd_trans_chain (a b c : Nat) (hab : a ∣ b) (hbc : b ∣ c) : a ∣ c :=
  Nat.dvd_trans hab hbc

-- ===== modular.lean =====
-- T09: modular arithmetic + divisibility, from first principles (core Lean 4, no Mathlib).
-- (Only theorems that verify cleanly in core are kept — no ring/ring_nf, no forced quadratic omega.)

-- (a) if d ∣ a and d ∣ b (b ≤ a) then d ∣ (a - b).
theorem dvd_sub_of_dvd (d a b : Nat) (hab : b ≤ a) (ha : d ∣ a) (hb : d ∣ b) : d ∣ (a - b) := by
  obtain ⟨x, hx⟩ := ha; obtain ⟨y, hy⟩ := hb
  exact ⟨x - y, by rw [hx, hy, ← Nat.mul_sub]⟩

-- (b) (a*b) mod m depends only on residues: (a*b) % m = ((a%m)*(b%m)) % m.
theorem mul_mod_residue (a b m : Nat) : (a*b) % m = ((a % m) * (b % m)) % m :=
  Nat.mul_mod a b m

-- (c) square mod m depends only on residue.
theorem sq_mod_residue (n m : Nat) : (n*n) % m = ((n % m)*(n % m)) % m :=
  Nat.mul_mod n n m

-- (d) if d ∣ a then d ∣ a*b (any b) — divisibility absorbs multiplication.
theorem dvd_absorb_mul (d a b : Nat) (h : d ∣ a) : d ∣ a*b := by
  obtain ⟨c, hc⟩ := h
  exact ⟨c*b, by rw [hc, Nat.mul_assoc]⟩

-- ===== gcd_trans.lean =====
-- T10: more divisibility / gcd theorems from first principles (core Lean 4, no Mathlib).

-- (a) gcd(a,a) = a.
theorem gcd_self (a : Nat) : Nat.gcd a a = a := Nat.gcd_self a

-- (b) 1 divides everything.
theorem one_dvd (n : Nat) : 1 ∣ n := Nat.one_dvd n

-- (c) if a ∣ b and b ∣ a then a = b (antisymmetry of divisibility).
theorem dvd_antisymm (a b : Nat) (hab : a ∣ b) (hba : b ∣ a) : a = b :=
  Nat.dvd_antisymm hab hba

-- (d) transitivity: a ∣ b, b ∣ c ⟹ a ∣ c^(k+1) (combines T08-style power with transitivity).
theorem dvd_pow_trans (a b c k : Nat) (hab : a ∣ b) (hbc : b ∣ c) : a ∣ c ^ (k+1) := by
  have hac : a ∣ c := Nat.dvd_trans hab hbc
  induction k with
  | zero => simpa using hac
  | succ m ih =>
    rw [Nat.pow_succ]
    obtain ⟨t, ht⟩ := ih
    exact ⟨t * c, by rw [ht]; ac_rfl⟩

-- ===== parity.lean =====
-- T11: elementary number theory / parity, from first principles (core Lean 4, no Mathlib).

-- (a) sum of two evens is even.
theorem even_add_even (a b : Nat) (ha : a % 2 = 0) (hb : b % 2 = 0) : (a + b) % 2 = 0 := by
  omega

-- (b) sum of two odds is even.
theorem odd_add_odd (a b : Nat) (ha : a % 2 = 1) (hb : b % 2 = 1) : (a + b) % 2 = 0 := by
  omega

-- (c) even + odd is odd.
theorem even_add_odd (a b : Nat) (ha : a % 2 = 0) (hb : b % 2 = 1) : (a + b) % 2 = 1 := by
  omega

-- (d) every number divides its own multiple.
theorem dvd_own_mul (a k : Nat) : a ∣ a * k := ⟨k, rfl⟩

-- (e) 0 is divisible by everything.
theorem dvd_zero_all (n : Nat) : n ∣ 0 := Nat.dvd_zero n

-- (f) common divisor of two numbers divides their sum.
theorem dvd_sum (a b c : Nat) (hb : a ∣ b) (hc : a ∣ c) : a ∣ (b + c) := Nat.dvd_add hb hc

-- ===== local_descent.lean =====
-- Collatz-LOCAL descent lemma (core Lean 4). SCOPE: n ≡ 1 (mod 4) only. NOT the global conjecture.
-- Collatz map
def T (n : Nat) : Nat := if n % 2 = 0 then n / 2 else 3*n + 1

-- The three explicit steps for n = 4k+1 (k ≥ 1), derived (not assumed):
--   T(4k+1) = 12k+4  (odd input)
--   T(12k+4) = 6k+2  (even)
--   T(6k+2) = 3k+1   (even)
-- Hence T(T(T(4k+1))) = 3k+1 < 4k+1.

theorem T_step1 (k : Nat) : T (4*k+1) = 12*k+4 := by
  unfold T
  have hodd : (4*k+1) % 2 = 1 := by omega
  simp [hodd]
  omega

theorem T_step2 (k : Nat) : T (12*k+4) = 6*k+2 := by
  unfold T
  have heven : (12*k+4) % 2 = 0 := by omega
  simp [heven]
  omega

theorem T_step3 (k : Nat) : T (6*k+2) = 3*k+1 := by
  unfold T
  have heven : (6*k+2) % 2 = 0 := by omega
  simp [heven]
  omega

-- Composed: T^3 on 4k+1 equals 3k+1
theorem T3_on_4k1 (k : Nat) : T (T (T (4*k+1))) = 3*k+1 := by
  rw [T_step1, T_step2, T_step3]

-- LOCAL DESCENT: for k ≥ 1 (i.e. n = 4k+1 > 1), T^3(n) < n.
theorem collatz_local_descent (k : Nat) (hk : 1 ≤ k) : T (T (T (4*k+1))) < 4*k+1 := by
  rw [T3_on_4k1]
  omega