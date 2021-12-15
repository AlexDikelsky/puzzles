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

startmap ← (≠ subs) ↑ /⁼ ∧ keys ⊐ UnHash¨ Hash˘ 2 ↕ startstr

AddAtIdxs ← {
  map 𝕊 ⟨is, n⟩:
    (n⊸+)⌾(is⊸⊏) 0¨map
}

Step ← {
  𝕊 map:
    addwith ← (map > 0) / ((keys⊸⊐¨ Split¨ subs) ⋈¨ map )
    +´ map⊸AddAtIdxs¨ addwith
}

Solve ← {
  evaled ← Step⍟𝕩 startmap
  firstchars ← +´¨ (({𝕩 ⊑ evaled}¨¨)⌾⥊) ⊔ (⊑¨ keys) - 'A'
  withlastadded ← (1⊸+ ⌾ (((¯1 ⊑ startstr) - 'A')⊸⊑)) 26 ↑ firstchars
  (⌈´ - ⌊´) (0⊸≠ / ⊣) withlastadded
}

•Show Solve 10
•Show Solve 40
