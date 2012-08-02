if exists("b:mytexplugin")
  finish
endif
let b:mytexplugin = 1
nmap <silent> <leader>. :ScreenShell zsh <cr>
nmap <silent> <leader>< :call ScreenShellSend('make') <cr>
nmap <silent> <leader>> :call ScreenShellSend('make clobber') <cr>
