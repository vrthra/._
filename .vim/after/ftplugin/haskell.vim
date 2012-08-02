if exists("b:myhaskellplugin")
  finish
endif
let b:myhaskellplugin = 1
nmap <silent> <leader>. :ScreenShell ghci -XTemplateHaskell -XQuasiQuotes -XMonadComprehensions <cr>
nmap <silent> <leader>< :call ScreenShellSend(':l ' . expand("%:p")) <cr>
nmap <silent> <leader>> :call ScreenShellSend(':reload ') <cr>
nmap <silent> <leader>h :call ScreenShellSend(':hoogle ' . expand("<cWORD>")) <cr>
nmap <silent> <leader>t :call ScreenShellSend(':t ' . expand("<cWORD>")) <cr>
