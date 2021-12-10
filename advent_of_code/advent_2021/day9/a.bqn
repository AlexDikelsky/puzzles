primes ← •Import "primes.bqn"
input ← (•file.Lines "data.txt") - '0'

width ← ⊑ ≠¨ input
height ← ≠ input
data ← ⟨height, width⟩ ⥊ ∾input

min_locs ← (⌊´ ⟨∞⊸»˘ data, ∞⊸«˘ data, (∞⊸«˘⌾⍉) data, (∞⊸»˘⌾⍉) data⟩) > data

•Show +´+˝ min_locs × (1 + data)

wall ← data ≠ 9
primelist ← primes.PrimesTo 100000

FirstPrimeDividing ← {
  z FirstPrimeDividing 0: 0; # Defining this here so the code below works better
  ⟨⟩ FirstPrimeDividing n: "Primes list too small" ! 0 ;
  primes FirstPrimeDividing n: 0 = (⊑ primes) | n ? {
    ⊑ primes
  };
  primes FirstPrimeDividing n: {
    (1 ↓ primes) FirstPrimeDividing n
  }
}

Color ← {
  Color visited: {
    shifted ← +´ ⟨»˘ visited, «˘ visited, («˘⌾⍉) visited, (»˘⌾⍉) visited, visited⟩
    shifted × wall
  }
}

# Drop the first 5000 primes to make sure there aren't extra factors
•Show (((((0 ∾ 1 ↓ ∊)×⊣)+`)⌾⥊) min_locs) ⊏ 0 ∾ 5000 ↓ primelist
