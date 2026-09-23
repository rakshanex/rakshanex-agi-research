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
