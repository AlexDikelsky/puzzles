strs ← •Import "strings.bqn"

data ← •FLines "data.txt"

ParseNat ← {
  +´ (10 ⋆ (⌽↕≠𝕩)) × 𝕩 - '0' 
}

ParseBingo ← {
  ! 6 = ≠ 𝕩
  a ← ∾' '⊸strs.Split¨ 1 ↓ 𝕩
  b ← ParseNat¨ (0≠≠¨a) / a 
  ! 25 = ≠b
  ⟨5, 5⟩ ⥊ b
}

Steps ← {
  nums Steps board:
    data ← ⟨5, 5⟩ ⥊ nums ⊐ (⟨25⟩ ⥊ board)
    ⌊´ (⌈˝ data) ∾ (⌈˝˘ data)
}

Score ← {
  nums Steps board:
    data ← ⟨5, 5⟩ ⥊ nums ⊐ (⟨25⟩ ⥊ board)
    used ← ¬(≠nums) = data 
    col ← (5 = +˝used ) / board
    row ← (5 = +˝˘used) / board
    ! 1 = (≠ col) + (≠ row)
    (⊑⌽nums) × +´⥊board × ¬used
}

Subset ← {
  ((1+6×𝕩) +↕6) ⊏ data
}

nums ← ParseNat¨ ',' strs.Split ⊑ data

boards ← ParseBingo¨ Subset¨ ↕((≠data)-1) ÷ 6
as ← nums⊸Steps¨ boards
minsteps ← ⌊´ as
maxsteps ← ⌈´ as
sol1_idx ← ⊑ as ⊐ minsteps
sol2_idx ← ⊑ as ⊐ maxsteps
•Show ((1+minsteps) ↑ nums) Score sol1_idx ⊑ boards 
•Show ((1+maxsteps) ↑ nums) Score sol2_idx ⊑ boards
