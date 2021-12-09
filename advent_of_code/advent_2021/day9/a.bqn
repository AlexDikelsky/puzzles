input ← (•file.Lines "data.txt") - '0'

width ← ⊑ ≠¨ input
height ← ≠ input
data ← ⟨height, width⟩ ⥊ ∾input

mins ← ⌊´ ⟨∞⊸»˘ data, ∞⊸«˘ data, (∞⊸«˘⌾⍉) data, (∞⊸»˘⌾⍉) data⟩

•Show +´+˝ (mins > data) × (1 + data)

_K_ ← {
  𝔽˘ (𝔾˘ 𝕩) > 𝕩 
}

# •Show data
# •Show (mins > data) × data
# •Show (((∞⊸«) _K_ (∞⊸»)) data) × data
# •Show (((∞⊸») _K_ (∞⊸«)) data) × data
# •Show (((∞⊸«⌾⍉) _K_ (∞⊸»⌾⍉)) data) × data
# •Show (((∞⊸»⌾⍉) _K_ (∞⊸«⌾⍉)) data) × data
