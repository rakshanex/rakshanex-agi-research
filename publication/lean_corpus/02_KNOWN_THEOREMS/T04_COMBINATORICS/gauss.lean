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
