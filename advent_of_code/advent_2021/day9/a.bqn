input ← (•file.Lines "data.txt") - '0'

width ← ⊑ ≠¨ input
height ← ≠ input
data ← ⟨height, width⟩ ⥊ ∾input

min_locs ← (⌊´ ⟨∞⊸»˘ data, ∞⊸«˘ data, (∞⊸«˘⌾⍉) data, (∞⊸»˘⌾⍉) data⟩) > data

•Show +´+˝ min_locs × (1 + data)

_K_ ← {
  1⊸𝔽˘ ((∞⊸𝔾˘ 𝕩) > 𝕩)
}

# Below are (0,1) matricies
# 0: the element to the _ is downhill
# 1: the element to the _ is uphill
# This has bugs I think
right ← ((« _K_ ») data)
left  ← ((» _K_ «) data)
up    ← (((«⌾⍉) _K_ (»⌾⍉)) data)
down  ← (((»⌾⍉) _K_ («⌾⍉)) data)

•Show data
•Show up
