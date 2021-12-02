data ← •FLines "data.txt"

ParseNat ← {
  +´ (10 ⋆ (⌽↕≠𝕩)) × 𝕩 - '0' 
}

ParseStart ← {
  'f': ⟨ 1, 0⟩ ;
  'l': ⟨¯1, 0⟩ ;
  'd': ⟨0,  1⟩ ;
  'u': ⟨0, ¯1⟩
}

ParseLine ← {
  (ParseStart ⊑ 𝕩) × ParseNat (1 + 𝕩 ⊐ " ") ↓ 𝕩
}


•Out •Repr ×´ +´ ParseLine¨ data
