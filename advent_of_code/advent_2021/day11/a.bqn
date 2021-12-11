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

n ← 0

G ← {
  G data: data ≡ (height‿width ⥊ 0) ? {
    •Show n
    data
  };
  G data: {
    n ↩ n + 1
    F¨ Iterate ⟨height‿width ⥊ 0, data, height‿width ⥊ 0⟩
  }
}

•Show G⍟900 data
