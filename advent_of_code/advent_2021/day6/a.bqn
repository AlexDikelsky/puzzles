Split ← (•Import "strings.bqn").Split

ParseNat ← {
  +´ (10 ⋆ (⌽↕≠𝕩)) × 𝕩 - '0' 
}

input ← ParseNat¨ ',' Split ⊑ •FLines "data.txt"

dat ← (⊑ ⋈ ≠)¨ ((0≠≠¨)/⊣) ⊔˜input

Step ← {
  shifted ← 1 ⌽ 𝕩  
  ((¯1 ⊑ shifted)⊸+)⌾(6⊸⊑) shifted
}

A ← { 
  b A ⟨idx, v⟩: {
    K ← { 
      K ⟨idx, v⟩: ((v⊸+) ⌾ (idx⊸⊑)) 
    }
    a ← K ⟨idx, v⟩
    A b
  }
}
B ← {
  v B ⟨⟩ : v ;
  v B pairs: (v A ⊑ pairs) B 1 ↓ pairs 
}

•Show +´(Step⍟80) (9⥊0) B dat
•Show +´(Step⍟256) (9⥊0) B dat
