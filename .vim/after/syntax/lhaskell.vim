" Vim syntax file
" Language:	C Additions
" Maintainer:	Mikhail Wolfson <mywolfson@gmail.com>
" URL: http://web.mit.edu/wolfsonm
" Last Change:	2010 Dec. 3
" Version: 0.4
"
syn match mRed "\[[^]]*\]" contained
syn match mGreen "([^)]*)" contained
syn match mYellow "{[^}]*}" contained
syn match mBlue "<[^>]*>" contained
syn match mGray "^|.*$" contains=mRed,mGreen,mYellow,mBlue
syn match mImp "^!.*$"

syn region mBlock start="<\[" end="]>" contains=mRed,mGreen,mYellow,mBlue

syn keyword mMark TODO XXX


"Comment Constant Identifier Statement PreProc Type Special String Character 
"Number Boolean Float Function Conditional Repeat Label Operator Keyword
"Include Define Macro PreCondit StorageClass Structure Typedef Tag
hi def link mMark Label
hi def link mRed String
hi def link mGray Comment
hi def link mGreen Question
hi def link mYellow Special
hi def link mBlue Identifier
hi def link mImp String

