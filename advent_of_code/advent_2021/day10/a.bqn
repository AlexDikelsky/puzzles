data ← •file.Lines "data.txt"

open ← "{<[("
close ← "}>])"


Score2 ← {
  Score2 '(': 1;
  Score2 '[': 2;
  Score2 '{': 3;
  Score2 '<': 4;
  Score x: x ! 0
}

Score1 ← {
  Score1 '>': 25137;
  Score1 '}': 1197;
  Score1 ']': 57;
  Score1 ')': 3
}

Score3 ← {  𝕩 }

Process1 ← {
  stack Process1 ⟨⟩: {
    0
  };
  stack Process1 str: ⊑ (⊑ str) ∊ open ? {
    ((⊑ str) ∾ stack) Process1 1 ↓ str
  };
  stack Process1 str: (⊑ (⊑ str) ∊ close) ∧ ((≠stack) > 0) ? {
    ⟨s, st⟩ ← (⊑⋈1⊸↓) stack
    ⟨x, xs⟩ ← (⊑⋈1⊸↓) str

    ((close ⊐ x) ≡ (open ⊐ s))◶⟨Score1 x, st Process1 xs⟩ @
  };
  stack Process1 str: (⊑ (⊑ str) ∊ close) ∧ ((=stack) > 0) ? {
    ⟨x, xs⟩ ← (⊑⋈1⊸↓) str
    Score1 x
  }
}

Process ← {
  ⟨⟩ Process ⟨⟩: {
    0
  };
  stack Process ⟨⟩: {
    0 { ((5⊸× 𝕩) + Score2 𝕨) }´ ⌽ stack
  };
  stack Process str: ⊑ (⊑ str) ∊ open ? {
    ((⊑ str) ∾ stack) Process 1 ↓ str
  };
  stack Process str: (⊑ (⊑ str) ∊ close) ∧ ((≠stack) > 0) ? {
    ⟨s, st⟩ ← (⊑⋈1⊸↓) stack
    ⟨x, xs⟩ ← (⊑⋈1⊸↓) str

    ((close ⊐ x) ≡ (open ⊐ s))◶⟨0, st Process xs⟩ @
  };
  stack Process str: (⊑ (⊑ str) ∊ close) ∧ ((=stack) > 0) ? {
    ⟨x, xs⟩ ← (⊑⋈1⊸↓) str
    0
  }
}

•Show +´ ⟨⟩⊸Process1¨ data
•Show ({2⊸(÷˜) ¯1 + ≠ 𝕩} ⊑ ⊢) (0⊸≠ / ⊢) (∧ ⟨⟩⊸Process¨ data)
