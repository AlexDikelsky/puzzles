str ← •Import "strings.bqn"

data ←  ' ' str.Split¨¨ str.Trim¨¨ '|' str.Split ¨ •file.Lines "data.txt"

s ← ≠¨ ∾ 1⊸⊑¨ data

CharsToVec ← {
  +˝ 𝕩 =⌜ ('a' + ↕7)
}

Back ← {
  𝕩 / "abcdefg"
}

Part2 ← {
  Part2 ⟨digits, choose⟩: {
    one ← CharsToVec ⊑ ((2⊸=≠¨) / ⊣ ) digits
    four ← CharsToVec ⊑ ((4⊸=≠¨) / ⊣ ) digits
    seven ← CharsToVec ⊑ ((3⊸=≠¨) / ⊣ ) digits
    eight ← CharsToVec ⊑ ((7⊸=≠¨) / ⊣ ) digits
    two_three_five ← CharsToVec¨ ((5⊸=≠¨) / ⊣ ) digits
    zero_six_nine ← CharsToVec¨ ((6⊸=≠¨) / ⊣ ) digits

    six ← ⊑ (1 = +´¨ 2 =⌜ one⊸+¨ zero_six_nine) / zero_six_nine
    zero_nine ← (2 = +´¨ 2 =⌜ one⊸+¨ zero_six_nine) / zero_six_nine
    nine ← ⊑ (4 = +´¨ 2 =⌜ four⊸+¨zero_nine) / zero_nine
    zero ← ⊑ (3 = +´¨ 2 =⌜ four⊸+¨zero_nine) / zero_nine

    five ← ⊑ (1 = +´¨ 0 =⌜ six⊸+¨ two_three_five) / two_three_five
    two_three ← (0 = +´¨ 0 =⌜ six⊸+¨ two_three_five) / two_three_five
    two ← ⊑ (2 = +´¨ (2 =⌜ four⊸+¨two_three)) / two_three
    three ← ⊑ (3 = +´¨ (2 =⌜ four⊸+¨two_three)) / two_three

    
    ⟨zero, one, two, three, four, five, six, seven, eight, nine⟩ ⊐ (CharsToVec¨ choose)

  }
}

•Show +´ (s = 2) + (s = 4) + (s = 3) + (s = 7)
•Show +´+´ str.ToNats¨ '0' + Part2¨ data
