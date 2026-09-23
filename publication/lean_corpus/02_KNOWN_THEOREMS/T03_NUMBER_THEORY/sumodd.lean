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
