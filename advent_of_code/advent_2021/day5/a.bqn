input ← •FLines "data.txt"
Split ← (•Import "strings.bqn").Split

ParseNat ← {
  +´ (10 ⋆ (⌽↕≠𝕩)) × 𝕩 - '0' 
}

ParseLine ← {
  ⟨a, bc, d⟩ ← ',' Split 𝕩
  ⟨b, arrow, c⟩ ← ' ' Split bc
  (ParseNat¨ (a ⋈ b)) ⋈ (ParseNat¨ (c ⋈ d))
}

LineIncluding ← {
    LineIncluding ⟨⟨a, b⟩, ⟨c, d⟩⟩: a = c ? a⊸⋈¨ (b ⌊ d) + ↕ 1 + (| b - d) ;
    LineIncluding ⟨⟨a, b⟩, ⟨c, d⟩⟩: b = d ? ⌽¨ LineIncluding ⟨⟨b, a⟩, ⟨d, c⟩⟩ ;

    LineIncluding ⟨⟨a, b⟩, ⟨c, d⟩⟩: (a < c) ∧ (b < d) ? (<⟨a, b⟩) + ⋈˜¨(↕1 + (c - a)) ;
    LineIncluding ⟨⟨a, b⟩, ⟨c, d⟩⟩: (a > c) ∧ (b < d) ? (<⟨a, b⟩) + (<⟨-1, 1⟩) × ⋈˜¨(↕1 + (a - c)) ;

    LineIncluding ⟨⟨a, b⟩, ⟨c, d⟩⟩: (a > c) ∧ (b > d) ? LineIncluding ⟨⟨c, d⟩, ⟨a, b⟩⟩ ;
    LineIncluding ⟨⟨a, b⟩, ⟨c, d⟩⟩: (a < c) ∧ (b > d) ? LineIncluding ⟨⟨c, d⟩, ⟨a, b⟩⟩
}

# https://mathoverflow.net/questions/117390/polynomial-bijection-from-zxz-to-z
Bij ← {
  Bij ⟨n, m⟩: ((n+m) × (n+m+1) ÷ 2) + m
}

Mark ← { (1⊸+)⌾(𝕩⊸⊑) 𝕨 }

HorizVert ← {
    (+´ =´ 𝕩) > 0
}
data ← ParseLine¨ input
p1_data ← (HorizVert¨ data) / data

m1 ←  Bij¨ ∾ LineIncluding¨ p1_data
m2 ←  Bij¨ ∾ LineIncluding¨ data

•Show +´ (((∊⌾⌽) × ⊒) m1) > 0
•Show +´ (((∊⌾⌽) × ⊒) m2) > 0
