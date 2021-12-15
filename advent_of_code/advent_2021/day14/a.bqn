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
    ⟨Hash ⟨a, b⟩,  Hash ⟨c, b⟩⟩
}

Step ← {
  𝕊 str:
}


len ← Hash "ZZ"
count ← ↕ len + 1
table ← 0¨count

# Assert this hash works
! ((UnHash¨ Hash¨) ≡ ⊣) ⊑¨ subs 

startmap ← /⁼ (∧ Hash˘ 2 ↕ startstr) ∾ len

# could be really bad, we'll see
•Show /⁼ ∧ ∾ Split¨ (((Hash¨ keys) ⊏ startmap) / subs)
