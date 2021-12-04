strs ← •Import "strings.bqn"

data ← •FLines "data.txt"

ParseNat ← {
  +´ (10 ⋆ (⌽↕≠𝕩)) × 𝕩 - '0' 
}

ParseBingo ← {
  ⟨5, 5⟩ ⥊ ParseNat¨ ((0≠≠¨) / ⊣) (∾ ' ' strs.Split¨ 1 ↓ 𝕩)
}

Steps ← { nums Steps board:
  ⌊´ (⌈˝  ∾ ⌈˝˘) (nums⊸⊐⌾⥊) board 
}

Score ← { nums Score board:
  unused ← (≠nums) = (nums⊸⊐⌾⥊) board 
  (⊑ ⌽ nums) × +´ ⥊ board × unused
}

Subset ← {
  ((1+6×𝕩) +↕6) ⊏ data
}

nums ← ParseNat¨ ',' strs.Split ⊑ data
boards ← ParseBingo¨ Subset¨ ↕((≠data)-1) ÷ 6

steps_per_board ← nums⊸Steps¨ boards
minsteps ← ⌊´ steps_per_board
maxsteps ← ⌈´ steps_per_board
sol1_idx ← ⊑ steps_per_board ⊐ minsteps
sol2_idx ← ⊑ steps_per_board ⊐ maxsteps
•Show ((1+minsteps) ↑ nums) Score sol1_idx ⊑ boards 
•Show ((1+maxsteps) ↑ nums) Score sol2_idx ⊑ boards
