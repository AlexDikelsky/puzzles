input ← (•file.Lines "data.txt") - '0'
width ←  ⊑ ≠¨ input
height ← ≠ input

data ← ⟨height, width⟩ ⥊ ∾ input

F ← {
  F x: x ≥ 9? 0;
  F x: x + 1
}

Iterate ← {
  Iterate ⟨flashed, vals, prev⟩: vals ≡ prev ? {
    •Show +´+˝ flashed
    vals
  };
  Iterate ⟨flashed, vals, prev⟩: {
    m ← (vals ≥ 9) - flashed


    add_with ← ⟨
     »˘ m, 
     «˘ m, 
     («˘⌾⍉) m, 
     (»˘⌾⍉) m, 
     »˘ («˘⌾⍉) m, 
     »˘ (»˘⌾⍉) m, 
     «˘ («˘⌾⍉) m, 
     «˘ (»˘⌾⍉) m,
    ⟩
    applied ← vals + +´ add_with
    Iterate ⟨(flashed + m), applied, vals⟩
  }
}

G ← {
  F¨ Iterate ⟨height‿width ⥊ 0, 𝕩, height‿width ⥊ 0⟩
}

G⍟100 data
