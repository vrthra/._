" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Rahul Nair <rahul_inblue at hotmail dot com>
" Last Change:	2003 May 02
" I dislike bold and reverse display, also very bright colors on my vim
" This is modified *koehler* theme with out the above mentioned.
hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "blufox"
hi Normal		  ctermfg=gray guifg=DarkGray  guibg=black
hi Scrollbar	  guifg=black guibg=gray
hi Menu			  guifg=black guibg=gray
hi SpecialKey	  term=bold  ctermfg=darkblue  guifg=Blue
hi NonText		  term=bold  ctermfg=darkblue  	guifg=Blue
hi Directory	  term=bold  ctermfg=darkblue	guifg=Blue
hi ErrorMsg		  term=standout  cterm=bold  ctermfg=white  guifg=White  guibg=black gui=bold
hi Search		  term=reverse	ctermfg=white ctermbg=black cterm=bold guifg=white  guibg=black gui=bold
hi MoreMsg		  term=bold  ctermfg=darkgreen	 guifg=SeaGreen
hi ModeMsg		  term=bold  guifg=White	guibg=Blue
hi LineNr		  term=underline  ctermfg=gray	guifg=gray
hi Question		  term=standout  ctermfg=green	 guifg=Green
hi StatusLine	  term=bold,reverse  ctermfg=darkblue guifg=blue guibg=white
hi StatusLineNC   term=reverse	ctermfg=white guifg=white guibg=blue
hi Title		  term=bold  ctermfg=magenta  guifg=Magenta
hi Visual		  term=reverse	cterm=reverse  gui=reverse
hi WarningMsg	  term=standout  ctermfg=red cterm=bold guifg=Red
hi Cursor		  guifg=bg	guibg=White
"hi Comment		  term=bold  cterm=bold ctermfg=cyan  guifg=#80a0ff
hi Comment		  term=bold  ctermfg=darkgray  guifg=#808080
"hi Constant		  term=underline  ctermfg=darkred  guifg=#ffa0a0
hi Constant		  term=underline  ctermfg=darkred  guifg=darkgreen
hi Special		  ctermfg=darkred  guifg=green
"hi Special		  term=bold  ctermfg=yellow  guifg=green
hi Identifier	  term=underline   ctermfg=darkblue  guifg=#40ffff
"hi Statement	  term=bold  cterm=bold ctermfg=yellow	gui=bold  guifg=#ffff60
hi Statement	  term=bold  ctermfg=darkblue	guifg=Blue
"hi PreProc		  term=underline  ctermfg=darkblue	guifg=#ff80ff
hi PreProc		  term=underline  ctermfg=darkblue	guifg=#80a0fF
"hi Type			  term=underline  cterm=bold ctermfg=lightgreen  gui=bold  guifg=#60ff60
hi Type			  term=underline  ctermfg=darkblue  guifg=#0000f0
hi Error		  term=standout ctermfg=red ctermbg=black guifg=Red	guibg=Black
hi Todo			  term=bold  ctermfg=darkcyan ctermbg=black guifg=White  guibg=Black
hi Pmenu          term=bold  ctermfg=darkblue ctermbg=white guifg=black  guibg=white
hi Pmenusel       term=bold  ctermfg=darkred ctermbg=white guifg=red  guibg=white
hi Pmenusbar      term=bold  ctermfg=darkblue ctermbg=black guifg=red  guibg=Black
hi Pmenuthumb     term=bold  ctermfg=darkblue ctermbg=black guifg=red  guibg=Black
hi link IncSearch		Visual
hi link String			Constant
hi link Character		Constant
hi link Number			Constant
hi link Boolean			Constant
hi link Float			Number
hi link Function		Identifier
hi link Conditional		Statement
hi link Repeat			Statement
hi link Label			Statement
hi link Operator		Statement
hi link Keyword			Statement
hi link Exception		Statement
hi link Include			PreProc
hi link Define			PreProc
hi link Macro			PreProc
hi link PreCondit		PreProc
hi link StorageClass	Type
hi link Structure		Type
hi link Typedef			Type
hi link Tag				Special
hi link SpecialChar		Constant
hi link Delimiter		Special
hi link SpecialComment	Comment
hi link Debug			Special
