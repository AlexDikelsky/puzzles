input ← (•file.Lines "data.txt") - '0'
data ← > input

F ← {
  F x: x ≥ 9 ? 0;
  F x: x + 1
}

Iterate ← {
  Iterate ⟨flashed, vals, prev⟩: vals ≡ prev ? vals ;
  Iterate ⟨flashed, vals, prev⟩: {
    m ← (vals ≥ 9) - flashed
    add_with ← ⟨
     »˘ m, «˘ m, 
     («˘⌾⍉) m, 
     (»˘⌾⍉) m, 
     »˘ («˘⌾⍉) m, 
     »˘ (»˘⌾⍉) m, 
     «˘ («˘⌾⍉) m, 
     «˘ (»˘⌾⍉) m,
    ⟩
    Iterate ⟨(flashed + m), vals + +´ add_with, vals⟩
  }
}

zero ← 0 × data

Step ← {
  F¨ Iterate ⟨zero, 𝕩, zero⟩
}

FindZeros ← {
  n FindZeros data: data ≡ zero ? n;
  n FindZeros data: (n + 1) FindZeros (Step data)
}

•Show +´+˝+´ 0 = Step⍟(↕101) data
•Show 0 FindZeros data
