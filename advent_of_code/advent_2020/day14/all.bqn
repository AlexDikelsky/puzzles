# •Out •Repr 1 ⊑ •FLines  "data.txt"

ParseInt ← {
  +´(10 ⋆ ⌽↕≠𝕩) × ('0'-˜ 𝕩)
}

Parse ← {
  ("mask" ≡ (↕4) ⊏ 𝕩)◶⟨
    ⟨
     ParseInt (4↓↕⊑(𝕩 ⊐ ']')) ⊏ 𝕩,
     ParseInt (2+⊑(𝕩 ⊐ '=')) ↓ 𝕩,
    ⟩,
    7 ↓ 𝕩⟩ @
}⚇1


•Out •Repr Parse "mask = X100110110X011000101000101XX11001X11"
•Out •Repr Parse "mem[54866] = 120526"

•Out¨ •Repr¨ Parse •FLines "data.txt"
