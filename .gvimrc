colorscheme desert
if has('multi_byte_ime')
  highlight Cursor guifg=NONE guibg=Green
  highlight CursorIM guifg=NONE guibg=Red
endif
set columns=120
set lines=60
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b

if filereadable(expand('~/.gvimrc.local'))
  source ~/.gvimrc.local
endif
