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

Winning ← {
  nums Steps board:
    data ← ⟨5, 5⟩ ⥊ nums ⊐ (⟨25⟩ ⥊ board)
    min ← ⌊´ (⌈˝ data) ∾ (⌈˝˘ data)
    used ← ¬(≠nums) = data 
    col ← (5 = +˝used ) / board
    row ← (5 = +˝˘used) / board
    ! 1 = (≠ col) + (≠ row)
    (⊑⌽nums) × +´⥊board × ¬used
}

Subset ← {
  ((1+6×𝕩) +↕6) ⊏ data
}

z ← Subset 2
x ← ParseNat¨ ',' strs.Split ⊑ data

boards ← ParseBingo¨ Subset¨ ↕((≠data)-1) ÷ 6
as ← x⊸Steps¨ boards
minsteps ← ⌊´ as
sol_idx ← ⊑ as ⊐ minsteps
•Show ((1+minsteps) ↑ x) Winning sol_idx ⊑ boards 
