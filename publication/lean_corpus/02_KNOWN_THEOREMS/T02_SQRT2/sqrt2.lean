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
