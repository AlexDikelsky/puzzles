Parse ← {
  +´ (10 ⋆ (⌽↕≠𝕩)) × 𝕩 - '0' 
}

data ← Parse¨ •file.Lines "data.txt"

p1d ← data + (∞ » data)
da1 ← p1d - (∞ » p1d)

p2d ← data + (∞ » data) + (⟨∞, ∞⟩ » data)
da2 ← p2d - (∞ » p2d)

•Out +´ da1 > 0
•Out +´ da2 > 0
