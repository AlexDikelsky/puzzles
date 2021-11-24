ParseInt ← {
  +´(10 ⋆ ⌽↕≠𝕩) × ('0'-˜ 𝕩)
}⚇1

ParseBin ← {
  +´(2 ⋆ ⌽↕≠𝕩) × ('0'-˜ 𝕩)
}⚇1

ToBase2Str ← {
  b ← '0' + 2{⌽𝕗|⌊∘÷⟜𝕗⍟(↕1+·⌊𝕗⋆⁼1⌈⊢)} 𝕩
  ((36-≠b)⥊'0') ∾ b
}⚇0

# This is really not good, once predicates come to CBQN it will be nicer
ParseE ← {
  0 ParseE str :
    ⟨
     ParseInt (4↓↕⊑(𝕩 ⊐ ']')) ⊏ str,
     ToBase2Str (ParseInt (2+⊑(str ⊐ '=')) ↓ str),
    ⟩ ;
  1 ParseE str :
    7 ↓ str 
}

Parse ← {
  ("mask" ≡ (↕4) ⊏ 𝕩) ParseE 𝕩
}⚇1

MaskIt ← {
  'X' MaskIt a:  a ;
  '0' MaskIt a: '0';
  '1' MaskIt a: '1'
}⚇0

RunStep ← {
  ⟨mask, mem⟩ RunStep line:
    ⟨36=≠line, mask, mem⟩ RunStepE line
}

RunStepE ← {
  ⟨0, mask, mem⟩ RunStepE addr‿value: 
    ⟨mask, ⟨⟨addr, ParseBin (mask MaskIt value)⟩⟩ ∾ mem⟩ ;
  ⟨1, mask, mem⟩ RunStepE newmask: ⟨newmask, mem⟩
}

# parsed ← Parse¨ •FLines "data.txt"
parsed ← Parse¨ •FLines "testdata.bqn"

default ← Parse "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

•Out •Repr ((((⟨default, ⟨⟩⟩ RunStep 0 ⊑ parsed) RunStep 1 ⊑ parsed) RunStep 2 ⊑ parsed) RunStep 3 ⊑ parsed)
⟨default, ⟨⟩⟩ RunStep´ parsed
