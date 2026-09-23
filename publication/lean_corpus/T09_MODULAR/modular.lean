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
