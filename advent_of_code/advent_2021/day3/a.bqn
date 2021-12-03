ParseBin ← {
  +´ (2 ⋆ (⌽↕≠𝕩)) × 𝕩
}

data ← '1' = •FLines "data.txt"
Gamma ← { (≠ 𝕩) ≤ 2 × +´ 𝕩 }
Epsil ← { (≠ 𝕩) > 2 × +´ 𝕩 }

A ← {
  0 A x: x ;
  y A x:
    oxy ← Gamma x
    idx ← (≠⊑data) - y
    value ← ((idx⊑oxy) = idx ⊑¨x) / x
    ((¬1 =≠ value) × (y - 1)) A value
}

B ← {
  0 B x: x ;
  y B x:
    oxy ← Epsil x
    idx ← (≠⊑data) - y
    value ← ((idx⊑oxy) = idx ⊑¨x) / x
    ((¬1 =≠ value) × (y - 1)) B value
}

•Out •Repr ×´ ParseBin¨ ⟨Gamma data, Epsil data⟩

•Out •Repr ×´ ParseBin¨ ⊑¨ ⟨(≠⊑data) A data, (≠⊑data) B data⟩
