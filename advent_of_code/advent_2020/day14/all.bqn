ParseInt ← {
  +´(10 ⋆ ⌽↕≠𝕩) × ('0'-˜ 𝕩)
}⚇1

ToBase2 ← {
  b ← '0' + 2{⌽𝕗|⌊∘÷⟜𝕗⍟(↕1+·⌊𝕗⋆⁼1⌈⊢)} 𝕩
  b
}⚇0

Parse ← {
  ("mask" ≡ (↕4) ⊏ 𝕩)◶⟨
    ⟨
     ParseInt (4↓↕⊑(𝕩 ⊐ ']')) ⊏ 𝕩,
     ParseInt (2+⊑(𝕩 ⊐ '=')) ↓ 𝕩,
    ⟩,
    7 ↓ 𝕩⟩ @
}⚇1

# MaskNum ← {
#   mask MaskNum 
# }

RunStep ← {
  ⟨mask, mem⟩ RunStep line:
    (36=≠𝕩)◶⟨
      ⟨𝕩, mem⟩
      ⟨mask, ⟩
    ⟩
}

parsed ← Parse¨ •FLines "data.txt"

# •Out •Repr Parse "mask = X100110110X011000101000101XX11001X11"
#•Out •Repr Parse "mem[54866] = 120526"

#•Out •Repr ToBase2 123

•Out¨ •Repr¨ parsed
# •Out ⟨2, 3⟩ RunStep "sdf"
