ParseBin ← { +´ (2 ⋆ (⌽↕≠𝕩)) × 𝕩 }

data ← '1' = •FLines "data.txt"
Gamma ← ≠ ≤ (2 × +´)
Epsil ← ≠ > (2 × +´)

Filter ← {
  ⟨0, F⟩ Filter x: x ;
  ⟨y, F⟩ Filter x:
    idx ← (≠⊑x) - y
    remaining ← ((idx ⊑ F x) = idx ⊑¨x) / x
    ⟨(¬1 =≠ remaining) × (y - 1), F⟩ Filter remaining
}

•Out •Repr ×´ ParseBin¨ ⟨Gamma data, Epsil data⟩

•Out •Repr ×´ ParseBin¨ ⊑¨ ⟨⟨≠⊑data, gamma⟩ Filter data, ⟨≠⊑data, epsil⟩ Filter data⟩
