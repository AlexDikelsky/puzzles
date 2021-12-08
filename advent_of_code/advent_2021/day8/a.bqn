str ← •Import "strings.bqn"

data ←  ' ' str.Split¨¨ str.Trim¨¨ '|' str.Split ¨ •file.Lines "data.txt"

s ← ≠¨ ∾ 1⊸⊑¨ data

CharsToVec ← {
  +˝ 𝕩 =⌜ ('a' + ↕7)
}

Part2 ← {
  Part2 ⟨digits, choose⟩: {
    one ← CharsToVec ⊑ ((2⊸=≠¨) / ⊣ ) digits
    four ← CharsToVec ⊑ ((4⊸=≠¨) / ⊣ ) digits
    seven ← CharsToVec ⊑ ((3⊸=≠¨) / ⊣ ) digits
    eight ← CharsToVec ⊑ ((7⊸=≠¨) / ⊣ ) digits
    two_three_five ← CharsToVec¨ ((5⊸=≠¨) / ⊣ ) digits
    zero_six_nine ← CharsToVec¨ ((6⊸=≠¨) / ⊣ ) digits

    a ← seven - one
    adg ← 3 = +´ two_three_five
    d ←  2 = four + adg
    bd ← 1 = four + one
    b ← 2 = bd + d
    cde ← 2 = +´ zero_six_nine 
    ce ← 2 = cde + d

    six ← ⊑ (1 = +´¨ 2 =⌜ one⊸+¨ zero_six_nine) / zero_six_nine
    zero_nine ← (2 = +´¨ 2 =⌜ one⊸+¨ zero_six_nine) / zero_six_nine
    zero ← ⊑ (4 = +´¨ 2 =⌜ four⊸+¨zero_nine) / zero_nine
    nine ← ⊑ (3 = +´¨ 2 =⌜ four⊸+¨zero_nine) / zero_nine
    e ← 1 = nine + eight 
    c ← 2 = ce + e
  }
}



•Show +´ (s = 2) + (s = 4) + (s = 3) + (s = 7)
•Show (Part2 ⊑ data)
