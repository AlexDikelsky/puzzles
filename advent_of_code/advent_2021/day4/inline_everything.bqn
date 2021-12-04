Split ← (•Import "strings.bqn").Split
data ← •FLines "data.txt"

Score ← { (¯1 ⊑ 𝕨) × +´ ⥊ (⊣ × (((≠𝕨)=𝕨⊸⊐) ⌾⥊)) 𝕩 }

ParseNat ← {
  +´ (10 ⋆ (⌽↕≠𝕩)) × 𝕩 - '0' 
}

ParseBoard ← { ⟨5, 5⟩⊸⥊ ParseNat¨ ((0≠≠¨) / ⊣) (∾ ' '⊸Split¨ 1⊸↓ 𝕩) }

nums ← ParseNat¨ ',' Split ⊑ data
boards ← ParseBoard¨ { ((1+6×𝕩) +↕6) ⊏ data }¨ ↕((≠data)-1) ÷ 6
wintimes ← (⌊´∘(⌈˝ ∾ ⌈˝˘)∘(nums⊸⊐⌾⥊))¨ boards

_Sol ← { ((1+𝔽´𝕩) ↑ 𝕨) Score ((⊑∘(⊣ ⊐ 𝔽´)) 𝕩) ⊑ boards }
•Show nums (⌊ _Sol) wintimes
•Show nums (⌈ _Sol) wintimes
