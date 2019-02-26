set fenc=utf-8
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac
set autoread
set hidden
set showcmd
set cursorline
set virtualedit=onemore
set smartindent
set visualbell
set laststatus=2
set wildmode=list:longest
set expandtab
set tabstop=2
set shiftwidth=2
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
set vb t_vb=
set shortmess+=I
set scrolloff=5

""""""""""""""""""""""""""""""
"foldmethod Setting
set foldmethod=indent
noremap [space] <nop>
  nmap <Space> [space]
noremap [space] za

""""""""""""""""""""""""""""""
"change insert mode status line color
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

""""""""""""""""""""""""""""""
" local setting
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

if filereadable(expand('~/.vimrc.develop'))
  source ~/.vimrc.develop
endif
