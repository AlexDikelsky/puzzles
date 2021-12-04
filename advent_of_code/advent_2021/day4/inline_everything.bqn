strs ← •Import "strings.bqn"
data ← •FLines "data.txt"

Score ← { (⊑ ⌽ 𝕨) × +´ ⥊ 𝕩 × (≠𝕨) = (𝕨⊸⊐⌾⥊) 𝕩 }

nums ← •BQN¨ ',' strs.Split ⊑ data
boards ← { ⟨5, 5⟩ ⥊ •BQN¨ ((0≠≠¨) / ⊣) (∾ ' ' strs.Split¨ 1 ↓ 𝕩) }¨ { ((1+6×𝕩) +↕6) ⊏ data }¨ ↕((≠data)-1) ÷ 6

steps_per_board ← nums⊸{ ⌊´ (⌈˝  ∾ ⌈˝˘) (𝕨⊸⊐⌾⥊) 𝕩 }¨ boards
minsteps ← ⌊´ steps_per_board
maxsteps ← ⌈´ steps_per_board
sol1_idx ← ⊑ steps_per_board ⊐ minsteps
sol2_idx ← ⊑ steps_per_board ⊐ maxsteps
•Show ((1+minsteps) ↑ nums) Score sol1_idx ⊑ boards 
•Show ((1+maxsteps) ↑ nums) Score sol2_idx ⊑ boards
