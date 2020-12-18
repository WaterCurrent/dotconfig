if !&compatible
  set nocompatible
endif
let g:python3_host_prog = '~/.venvs/nvim/bin/python3'

" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml('~/.config/nvim/dein.toml')
  call map(dein#check_clean(), "delete(v:val, 'rf')")
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if dein#check_install()
  call dein#install()
endif

""""""""""""""""""""""""""""""
set nocompatible
set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set notitle
set nowrap
set shortmess+=I
set history=10000
"set nobackup
"set noautoindent
set autoindent
set cursorline
set incsearch
set hlsearch
set showmatch
set tabstop=4
set shiftwidth=4
"set number
syntax on
""""""""""""""""""""""""""""""
"buffer
"nnoremap <silent> <C-j> :bprev<CR>
"nnoremap <silent> <C-k> :bnext<CR>
"""""""""""""""""""""""""""""""
"command line mode key bind
"cnoremap <C-b> <Left>
"cnoremap <C-f> <Right>
"cnoremap <C-n> <Down>
"cnoremap <C-p> <Up>
"cnoremap <C-a> <Home>
"cnoremap <C-e> <End>
"cnoremap <C-d> <Del>
"""""""""""""""""""""""""""""""
" mieenai monowo miru tokoro
":set list listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
":set list listchars=tab:»-,eol:↲,extends:»,precedes:«,nbsp:%
"""""""""""""""""""""""""""""""
"skk-vim options
"let g:skk_large_jisyo='~/.skk-dic/SKK-JISYO-utf8.L'
"let g:skk_egg_like_newline=1
"let g:skk_auto_save_jisyo=1
"let g:eskk#large_dictionary={
"	\	'path': "~/.skk-dic/SKK-JISYO-utf8.L",
"	\	'sorted': 1,
"	\	'encoding': 'utf-8',
"	\}
"""""""""""""""""""""""""""""""
"let g:deoplete#enable_at_startup = 1
"""""""""""""""""""""""""""""""
"起動時に有効
"let g:neocomplete#enable_at_startup = 1
"ポップアップメニューで表示される候補の数
"let g:neocomplete#max_list = 50
"キーワードの長さ、デフォルトで80
"let g:neocomplete#max_keyword_width = 80
"let g:neocomplete#enable_ignore_case = 1
"highlight Pmenu ctermbg=6
"highlight PmenuSel ctermbg=3
"highlight PMenuSbar ctermbg=0
"inoremap <expr><CR>  pumvisible() ? neocomplete#close_popup() : “<CR>”
"""""""""""""""""""""""""""""""
"autofmt option
"set formatexpr=autofmt#japanese#formatexpr()

"local setting {{{
if filereadable(expand('~/.config/nvim/init.vim.local'))
  source ~/.config/nvim/init.vim.local
endif
"}}}
