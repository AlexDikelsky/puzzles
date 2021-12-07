str ← •Import "strings.bqn"
data ← ∾ str.ToNats¨ ',' str.Split ⊑ •FLines "data.txt"

Cost1 ← {
  data Cost1 idx: +´ | data - idx 
}

# Triangle numbers
T ← {
  (𝕩 × (𝕩 + 1)) ÷ 2
}

Cost2 ← {
  data Cost2 idx: {
    +´ T¨ data ⊏ (| idx - ↕ 1 + ⌈´ data)
  }
}

min1 ← ⌊´ data⊸Cost1¨ ↕1 + ⌈´ data
min2 ← ⌊´ data⊸Cost2¨ ↕1 + ⌈´ data

•Show min1
•Show min2
