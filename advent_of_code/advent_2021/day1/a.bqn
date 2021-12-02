Parse ← {
  +´ (10 ⋆ (⌽↕≠𝕩)) × 𝕩 - '0' 
}

data ← •BQN¨ •FLines "data.txt"

p1d ← data > (∞ » data)
p2d ← data + (∞ » data) + (⟨∞, ∞⟩ » data)
da2 ← p2d > (∞ » p2d)

•Out +´ p1d
•Out +´ da2
