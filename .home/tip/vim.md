### Vim

- traverse changelist

    g; g,

- last insert mode

    gi

- Traverse jumps

   ^O , ^I

- yank (append) all lines containing text to A

    :g/rgba/y A

- Track a setting

    :verbose set cindent?

- reselect last visual selection

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

- goto file:number

  gF
