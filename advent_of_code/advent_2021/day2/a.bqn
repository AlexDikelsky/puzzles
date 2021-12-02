data ← •FLines "data.txt"

ParseNat ← {
  +´ (10 ⋆ (⌽↕≠𝕩)) × 𝕩 - '0' 
}

ParseLine ← {
  (⊑ 𝕩) ∾ ParseNat (1 + 𝕩 ⊐ " ") ↓ 𝕩
}

Run1 ← {
  ⟨'f', val⟩ Run1 ⟨width, depth⟩: ⟨width + val, depth⟩ ;
  ⟨'d', val⟩ Run1 ⟨width, depth⟩: ⟨width, depth + val⟩ ;
  ⟨'u', val⟩ Run1 ⟨width, depth⟩: ⟨width, depth - val⟩
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


•Out ×´ ⟨0, 0⟩ Run1´ ParseLine¨ data
•Out ×´ 2 ↑ (⟨0, 0, 0⟩ Run2´ ⌽ ParseLine¨ data)
