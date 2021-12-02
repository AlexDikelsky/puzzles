data ← •FLines "data.txt"

ParseNat ← {
  +´ (10 ⋆ (⌽↕≠𝕩)) × 𝕩 - '0' 
}

ParseStart1 ← {
  'f': ⟨ 1, 0⟩ ;
  'd': ⟨0,  1⟩ ;
  'u': ⟨0, ¯1⟩
}

ParseLine1 ← {
  (ParseStart1 ⊑ 𝕩) × ParseNat (1 + 𝕩 ⊐ " ") ↓ 𝕩
}

Run2 ← {
  ⟨'f', val⟩ Run2 ⟨width, depth, aim⟩: {
    ⟨width + val, depth + (aim × val), aim⟩
  } ;
  ⟨'d', val⟩ Run2 ⟨width, depth, aim⟩: {
    ⟨width, depth, aim + val⟩
  } ;
  ⟨'u', val⟩ Run2 ⟨width, depth, aim⟩: {
    ⟨width, depth, aim - val⟩
  }
}

ParseLine2 ← {
  (⊑ 𝕩) ∾ ParseNat (1 + 𝕩 ⊐ " ") ↓ 𝕩
}

•Out ×´ +´ ParseLine1¨ data
•Out ×´ 2 ↑ (⟨0, 0, 0⟩ Run2´ ⌽ ParseLine2¨ data)
