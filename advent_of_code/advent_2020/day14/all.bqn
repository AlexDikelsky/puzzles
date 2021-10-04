# •Out •Repr 1 ⊑ •FLines  "data.txt"

ParseMask ← {
  ("mask" ≡ (↕4) ⊏ 𝕩)◶⟨0, 7 ↓ 𝕩⟩ @
}⚇1

ParseMem ← {
  ("mem" ≡ (↕3) ⊏ 𝕩)◶⟨
    0,
   memaddr  ← (4↓↕⊑(𝕩 ⊐ ']')) ⊏ 𝕩
  ⟩ @
}⚇1



•Out •Repr ParseMask "mask = X100110110X011000101000101XX11001X11"
•Out •Repr ParseMask "mas asd"
•Out •Repr ParseMem  "mem[54866] = 120526"
