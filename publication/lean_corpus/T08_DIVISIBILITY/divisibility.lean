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
