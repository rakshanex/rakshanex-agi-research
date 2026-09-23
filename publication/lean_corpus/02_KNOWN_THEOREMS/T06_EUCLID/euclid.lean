-- T06: Euclid's Lemma from first principles (own Prime def + core Nat.Coprime machinery).
-- p prime, p ∣ a*b  =>  p ∣ a  ∨  p ∣ b.   Core Lean 4, no Mathlib.
open Classical

def Prime (p : Nat) : Prop := 2 ≤ p ∧ ∀ m, m ∣ p → m = 1 ∨ m = p

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
