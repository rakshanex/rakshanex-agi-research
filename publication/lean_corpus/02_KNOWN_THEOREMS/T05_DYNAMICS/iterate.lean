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
