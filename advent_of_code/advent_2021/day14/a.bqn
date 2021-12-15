input ← •file.Lines "data.txt"

startstr ← ⊑ input
subs ← (2⊸↑ ⋈ ¯1⊸⊑)¨ 2 ↓ input
⟨keys, vals⟩ ← (⊑¨ ⋈ 1⊸⊑¨) subs

Hash ← {
  𝕊 ⟨c, d⟩:
    ⟨a, b⟩ ← ⟨c, d⟩ - 'A'
    (26 × a) + b
}

UnHash ← {
  𝕊 n:
    ((⌊ n ÷ 26) ⋈ (26 | n)) + 'A'
}

Split ← {
  𝕊 ⟨⟨a, b⟩, c⟩:
    ⟨⟨a, c⟩, ⟨c, b⟩⟩
}

len ← Hash "ZZ"

# Assert this hash works
! ((UnHash¨ Hash¨) ≡ ⊣) ⊑¨ subs 

startmap ← /⁼ (∧ Hash˘ 2 ↕ startstr) ∾ len

AddAtIdxs ← {
  map 𝕊 ⟨is, n⟩:
    (n⊸+)⌾(is⊸⊏) map
}

Step ← {
  𝕊 map:
    applytimes ← (Hash¨ keys) ⊏ map
    toapply ← applytimes / subs

    splitcounts ← (Hash¨ Split¨ subs) ⋈¨ applytimes
    # •Show map⊸AddAtIdxs¨ splitcounts
    # •Show splitcounts

    z ← /⁼ ∧ len ∾ ∾ Hash¨ Split¨ toapply
    # •Show z
    z
}

indices ← ⊑¨ UnHash¨ / (1⊸↓⌾⌽)  Step⍟10 startmap

# maxes ← (0⊸≠ / { 𝕩 ⋈˜¨ 'A' + ↕≠𝕩 }) ≠¨ ⊔ ((¯1 ⊑ startstr) ∾ indices) - 'A'
# ⟨k, v⟩ ← (⊑¨ ⋈ 1⊸⊑¨) maxes
# •Show (⌈´ v) - (⌊´ v)
