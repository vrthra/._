if exists("b:hlintplugin")
  finish
endif
let b:hlintplugin = 1
nmap <silent> <leader>. :ScreenShell<cr>
nmap <silent> <leader>< :call ScreenShellSend('hlint -XNoCPP ' . expand("%:p")) <cr>
