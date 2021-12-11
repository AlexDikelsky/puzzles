primes ← •Import "primes.bqn"
input ← (•file.Lines "data.txt") - '0'

width ← ⊑ ≠¨ input
height ← ≠ input
data ← ⟨height, width⟩ ⥊ ∾input

min_locs ← (⌊´ ⟨∞⊸»˘ data, ∞⊸«˘ data, (∞⊸«˘⌾⍉) data, (∞⊸»˘⌾⍉) data⟩) > data

•Show +´+˝ min_locs × (1 + data)

wall ← data ≠ 9
primelist ← primes.PrimesTo 100000

LargestFactor ← {
  LargestFactor 0: 0;
  LargestFactor n: ⌈´ primes.Factor n
}

Color ← {
  Color visited: {
    shifted ← +´ ⟨»˘ visited, «˘ visited, («˘⌾⍉) visited, (»˘⌾⍉) visited, visited⟩
    LargestFactor¨ shifted × wall
  }
}

Iterate ← {
  prevnum Iterate mat: prevnum = +´+˝ 0 = 𝕩 ? mat;
  prevnum Iterate mat: (+´+˝ 0 = mat) Iterate Color mat
}

# The primes store information about which section they are part of
pmat ← (((((0 ∾ 1 ↓ ∊)×⊣)+`)⌾⥊) min_locs) ⊏ 0 ∾ 2 ↓ primelist
o ← ∨ ≠¨ ⊔ (0⊸≠ / ⊢) ⥊ 0 Iterate pmat
pmat2 ← (((((0 ∾ 1 ↓ ∊)×⊣)+`)⌾⥊) min_locs) ⊏ 0 ∾ 9 ↓ primelist
p ← ∨ ≠¨ ⊔ (0⊸≠ / ⊢) ⥊ 0 Iterate pmat
•Show o ≡ p
