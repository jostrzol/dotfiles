let g:go_fmt_command = "goimports"

" adapt for tab indents
setlocal listchars=tab:\ \ ,trail:·,nbsp:·
setlocal noexpandtab
setlocal tabstop=2

" disable colored column and auto-newlines
set textwidth=0

" key mppings
nnoremap ge <Plug>(go-if-err)

compiler go
