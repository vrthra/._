### Vim

- traverse changelist

    g; g,

- last insert modeA
A
    giA
A
- Traverse jumpsA
A
   ^O , ^IA
A
- yank (append) all lines containing text to AA
A
    :g/rgba/y AA
A
- Track a settingA
A
    :verbose set cindent?A
A
- reselect last visual selectionA
A
    gv

- commenting
   
   ^v  (down arrow: select first row)
   I #

- uncomment
  ^v (down arrow: select first row)
   x

- append
  ^v (down arrow)
  $ A <x>
