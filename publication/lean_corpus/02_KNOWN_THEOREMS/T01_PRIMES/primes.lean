-- T01: Infinitude of primes, plain Lean 4 core (no Mathlib).
open Classical

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
