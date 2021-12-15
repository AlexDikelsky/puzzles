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
    ⟨Hash ⟨a, c⟩,  Hash ⟨c, b⟩⟩
}

len ← Hash "ZZ"
count ← ↕ len + 1

# Assert this hash works
! ((UnHash¨ Hash¨) ≡ ⊣) ⊑¨ subs 

startmap ← /⁼ (∧ Hash˘ 2 ↕ startstr) ∾ len

Step ← {
  𝕊 map:
    toapply ← ((Hash¨ keys) ⊏ map) / subs
    (/⁼ ∧ len ∾ ∾ Split¨ toapply)
}

ToLetter ← {𝕩 > 1} / {('A' + ↕26) ⋈¨  𝕩} ≠¨ ⊔ 

•Show 2↕ startstr

•Show ((Hash¨ keys) ⊐ (Hash˘ (2 ↕ startstr)))
