if exists("b:myprologplugin")
  finish
endif
let b:myprologplugin = 1
nmap <silent> <leader>. :ScreenShell gprolog<cr>
nmap <silent> <leader>< :call ScreenShellSend('[' . expand("%:r") . '].') <cr>


