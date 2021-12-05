input ← •FLines "data.txt"
Split ← (•Import "strings.bqn").Split

ParseNat ← {
  +´ (10 ⋆ (⌽↕≠𝕩)) × 𝕩 - '0' 
}

ParseLine ← {
  ⟨a, bc, d⟩ ← ',' Split 𝕩
  ⟨b, arrow, c⟩ ← ' ' Split bc
  ParseNat¨¨ ⟨⟨a, b⟩, ⟨c, d⟩⟩
}

LineIncluding ← {
    LineIncluding ⟨⟨a, b⟩, ⟨c, d⟩⟩: a = c ? a⊸⋈¨ (b ⌊ d) + ↕ 1 + (| b - d) ;
    LineIncluding ⟨⟨a, b⟩, ⟨c, d⟩⟩: b = d ? ⌽¨ LineIncluding ⟨⟨b, a⟩, ⟨d, c⟩⟩ ;

    LineIncluding ⟨⟨a, b⟩, ⟨c, d⟩⟩: (a < c) ∧ (b < d) ? (<⟨a, b⟩) + ⋈˜¨(↕1 + (c - a)) ;
    LineIncluding ⟨⟨a, b⟩, ⟨c, d⟩⟩: (a > c) ∧ (b < d) ? (<⟨a, b⟩) + (<⟨-1, 1⟩) × ⋈˜¨(↕1 + (a - c)) ;

    LineIncluding ⟨⟨a, b⟩, ⟨c, d⟩⟩: (a > c) ∧ (b > d) ? LineIncluding ⟨⟨c, d⟩, ⟨a, b⟩⟩ ;
    LineIncluding ⟨⟨a, b⟩, ⟨c, d⟩⟩: (a < c) ∧ (b > d) ? LineIncluding ⟨⟨c, d⟩, ⟨a, b⟩⟩
}

data ← ParseLine¨ input

Run ← {
  +´ (((∊⌾⌽) × ⊒) ∾ LineIncluding¨ 𝕩) > 0
}

•Show Run (({𝕩 > 0}∘+´∘=´)¨ / ⊣) data
•Show Run data
