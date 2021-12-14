input ← •file.Lines "data.txt"
str ← •Import "strings.bqn"

Color ← {
  𝕊 0: ' ';
  𝕊 1: '#'
}

mask ← 'f' = ⊑¨ 1 ↑¨ input
folds ← (¯1⊸⊑∘⊑ ∾ (str.ToNats 1⊸⊑))¨ '='⊸str.Split¨ mask / input  
⟨xs, ys⟩ ← (⊑¨ ⋈ 1⊸⊑¨) ⌽ ∾¨ str.ToNats¨¨ ','⊸str.Split¨ 1⊸↓ ⌽ (¬mask) / input

Fold ← {
  ⟨'y', n⟩ 𝕊 ⟨xs, ys⟩:
    xs ⋈ ⥊ | ys - (2×n) × (ys > n) ;
  ⟨'x', n⟩ 𝕊 ⟨xs, ys⟩:
    ys ⋈˜ ⥊ | xs - (2×n) × (xs > n)
}

•Show ≠ ⍷ (⊑ ⋈¨ 1⊸⊑) (⊑ folds) Fold ⟨xs, ys⟩

as‿bs ← ⟨xs, ys⟩ Fold´ ⌽ folds

mask2 ← ('y'⊸= 0⊸⊑¨) folds

⟨h, w⟩ ← ¯1⊸⊑¨ ¯1⊸⊑¨ ((mask2 / ⊣) ⋈ ((¬mask2) / ⊣)) folds

•Show h‿w ⥊ Color¨ (↕ w×h) ∊ ⥊ (bs × w) + as
