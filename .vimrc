"-------------------------------
" Bundles
"-------------------------------
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
"-------------------------------
" My bundles
"-------------------------------
"Bundle 'syntastic'
Bundle 'vim-scripts/surround.vim'
Bundle 'vim-scripts/repeat.vim'
Bundle 'vrthra/blue'
Bundle 'vim-scripts/indent-motion'
Bundle 'vim-scripts/localvimrc'
"Bundle 'vim-scripts/YankRing.vim'
Bundle 'vim-scripts/fugitive.vim'
Bundle 'vim-scripts/ack.vim'
Bundle 'vim-scripts/gnupg.vim'
Bundle 'vim-scripts/VimClojure'
Bundle 'vim-pandoc/vim-pandoc'

"{
"Bundle 'substitute.vim'
"}

Bundle 'matchit.zip'
Bundle 'https://github.com/ervandew/screen'
"-------------------------------
filetype plugin indent on

"---------------------------------------
" Saner window width and wrapping.
set tabstop=2
set shiftwidth=2
"se columns=100
set expandtab
set wrap linebreak
set modeline
"textwidth=0
"---------------------------------------
" Use arrow keys to move through soft wrapped text
:map <Up> gk
:map <Down> gj
"---------------------------------------
" Get rid of ridiculous paren highlight
let loaded_matchparen = 1
"---------------------------------------
set keywordprg=look
" Use Ctrl k to look up word under cursor
:map <C-k> <Esc>:! yes \  \| head -100;  dict <cword>\|more <CR>

"---------------------------------------
" Restore cursor to file position in previous editing session.
"http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

"---------------------------------------
" http://vim.wikia.com/wiki/Make_views_automatic
" Restores the cursor to the last editing point
" `0 with viminfo
"au BufWritePost,BufLeave,WinLeave ?* mkview
"au BufWinEnter ?* silent loadview
"---------------------------------------

let mapleader = ","

"---------------------------------------
let g:ScreenShellInitialFocus='vim'
" Use  ,, for opening ghci and use ,. for evaluating a selection|line
"nmap <silent> <leader>. :ScreenShell ghci<cr>
"#nmap <silent> <leader>. :ScreenShellVertical ghci<cr>
vmap <C-c><C-c> :ScreenSend<CR>
nmap <C-c><C-c> vip<C-c><C-c>
"vmap <leader>, :ScreenSend<CR>
"nmap <leader>, vip<leader>,
vnoremap <C-c><C-t> ""y:call ScreenShellSend(':t <C-R>" ')<CR>

"nmap <silent> <leader>< :call ScreenShellSend(':l ' . expand("%:p")) <cr>
let g:ScreenImpl = 'Tmux'
let g:ScreenShellExternal = 1
"let g:ScreenShellHeight = 15
"let g:ScreenShellGnuScreenVerticalSupport = 'native'
let g:ScreenShellTerminal = 'xterm'

" Tmux
" Ctrl b % - split

"---------------------------------------
" Buffer control. ^n ^p
nnoremap <silent> <C-n> :bn<CR>
nnoremap <silent> <C-p> :bp<CR>
"---------------------------------------

" Use .lvimrc in each dirs. Prompt before loading?
let g:localvimrc_ask= 'no'
"---------------------------------------
colorscheme blue
"colorscheme wombat
"colorscheme desert
"---------------------------------------
syntax on

"---------------------------------------
" Please god no backup on my repo.
set nobackup
set noswapfile
"set backupdir=/tmp
"---------------------------------------
" ctags
" echo ':ctags' | ghci -v0 Examples/Project.lhs
"---------------------------------------
"Haskell
" gf on import goes to that file
" ^W ^F splits
setlocal include=^import\\s*\\(qualified\\)\\?\\s*
setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.'
setlocal suffixesadd=hs,lhs,hsc

"---------------------------------------
"Search and replace word under cursor.
nnoremap ;; :%s/\<<C-r><C-w>\>//gc<left><left><left>
"vnoremap ;; "hy:%s/<C-r>h//gc<left><left><left>
vnoremap ;; ""y:%s/<C-R>=escape(@", '/\')<CR>//gc<Left><Left><Left>
vnoremap ;/ ""y/<C-R>=escape(@", '/\')<CR>

"---------------------------------------
"Save to * and +
vnoremap ,c "*y:let @+ = @*<CR>
noremap ,c "*yy:let @+ = @*<CR>

"---------------------------------------
" autospell - sets the spell when insert mode is on.
" generally a pain in programming.
map <F5> :setlocal spell! spelllang=en_us<CR>
"nmap <silent> <leader>s :setlocal spell!<CR>
"autocmd InsertEnter * setlocal spell
"autocmd InsertLeave * setlocal nospell
"---------------------------------------

syntax on

" http://yanpritzker.com/2012/04/17/how-to-change-vim-syntax-colors-that-are-annoying-you/
"map ,hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>

"----------------------------
set nofoldenable
"-----------------synctex
"au BufWritePost *.tex silent call Tex_RunLaTeX()
"au BufWritePost *.tex silent !pkill -USR1 xdvi.bin
"noremap ,k :silent !pkill -USR1 xdvi.bin<CR>

"----------------------------
"high light ruby trailing errors
let ruby_space_errors = 1
"----------------------------
" highlight trailing space only in command mode.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
if version >= 702
  autocmd BufWinLeave * call clearmatches()
endif
"----------------------------

set ignorecase
set smartcase

set incsearch
set showmatch
set hlsearch
"---------------------------------------
" Get rid of color highlight
nnoremap <leader><space> :noh<cr>

"---------------------------------------
" get a new line with out the silly #
nnoremap <leader><CR> A<CR><Esc>0d$
"---------------------------------------

" Colourized column if we want to ensure we dont go beyond 80 char limit
"set colorcolumn=80

set wrap
set textwidth=79
set formatoptions=qrn1
nnoremap <leader>q gqip
nnoremap <leader>v V`]

" for when we want to use ctags.
"set tags=./tags;/
"tags+=tags;$HOME


nnoremap <leader>d O require 'ruby-debug'; debugger
" Sync with the system clipboard.
set clipboard=unnamedplus
" sync with cut buffer
" set clipboard=unnamed

nnoremap <silent> <C-i> <esc>:r!cat;echo<CR>
"set ww=<,>,[,]
" remove the annoying backspace wrapping.
se backspace=indent,start

" disable comment autocomplete
"au FileType * setl fo-=cro
set fo-=c fo-=o fo-=r
set matchpairs=[:],{:},<:>,(:)

setlocal commentstring=<!--%s-->
setlocal comments=s:<!--,m:\ \ \ \ ,e:-->

"set scrolloff=1000
nmap <space> zz
