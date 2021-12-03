ParseBin ← { +´ (2 ⋆ (⌽↕≠𝕩)) × 𝕩 }

data ← '1' = •FLines "data.txt"
Gamma ← ≠ ≤ (2 × +´)
Epsil ← ≠ > (2 × +´)

Filter ← {
  ⟨0, F⟩ Filter x: x ;
  ⟨y, F⟩ Filter x:
    idx ← (≠⊑x) - y
    remaining ← (((idx ⊑ F) = idx⊸⊑¨) / ⊣) x
    ⟨(¬ 1 =≠ remaining) × (y - 1), F⟩ Filter remaining
  ;
  y Filter x:
    ⟨≠⊑data, y⟩ Filter x
}

•Show ×´ ParseBin¨ ⟨Gamma data, Epsil data⟩
•Show ×´ ParseBin¨ ⊑¨ ⟨gamma, epsil⟩ Filter¨ ⟨data, data⟩
