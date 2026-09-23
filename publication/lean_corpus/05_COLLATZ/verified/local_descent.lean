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
