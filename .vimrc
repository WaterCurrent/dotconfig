colorscheme default
set nocompatible
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
set tabstop=4
set shiftwidth=4
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
set vb t_vb=
set shortmess+=I
set scrolloff=5
set mouse=
set history=10000
set showmatch
""""""""""""""""""""""""""""""
"buffer
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>
""""""""""""""""""""""""""""""
"command line mode key bind
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
""""""""""""""""""""""""""""""
"foldmethod Setting
"set foldmethod=indent
"noremap [space] <nop>
"  nmap <Space> [space]
"noremap [space] za
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
"syntax check php when :w
function! s:PHPLint()
  let s:result = system('php -l ' . bufname(""))
  let s:count = split(s:result, "\n")
  echo s:result
endfunction

augroup php-lint
  autocmd!
  autocmd BufWritePost *.php call <SID>PHPLint()
augroup END
""""""""""""""""""""""""""""""
" local setting
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

if filereadable(expand('~/.vimrc.plugged'))
  source ~/.vimrc.plugged
endif
