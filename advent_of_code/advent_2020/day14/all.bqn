ParseInt ← {
  +´(10 ⋆ ⌽↕≠𝕩) × ('0'-˜ 𝕩)
}⚇1

ToBase2 ← {
  b ← '0' + 2{⌽𝕗|⌊∘÷⟜𝕗⍟(↕1+·⌊𝕗⋆⁼1⌈⊢)} 𝕩
  ((36-≠b)⥊'0') ∾ b
}⚇0

# This is really jank, once predicates come to CBQN it will be nicer
ParseE ← {
  0 ParseE str :
    ⟨
     ParseInt (4↓↕⊑(𝕩 ⊐ ']')) ⊏ str,
     ToBase2 (ParseInt (2+⊑(str ⊐ '=')) ↓ str),
    ⟩ ;
  1 ParseE str :
    7 ↓ str 
}

Parse ← {
  ("mask" ≡ (↕4) ⊏ 𝕩) ParseE 𝕩
}⚇1


RunStep ← {
  ⟨mask, mem⟩ RunStep line:
    (36=≠𝕩)◶⟨
      ⟨𝕩, mem⟩
      ⟨mask, ⟩
    ⟩
}

parsed ← Parse¨ •FLines "data.txt"

•Out •Repr Parse "mask = X100110110X011000101000101XX11001X11"
•Out •Repr Parse "mem[54866] = 120526"

#•Out •Repr ToBase2 1838761

#•Out¨ •Repr¨ parsed
# •Out ⟨2, 3⟩ RunStep "sdf"
