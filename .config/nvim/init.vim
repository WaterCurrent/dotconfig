if !&compatible
  set nocompatible
endif

" dein {{{1
" dein自体の自動インストール{{{2
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
"}}}2
" プラグイン読み込み＆キャッシュ作成{{{2
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml('~/.config/nvim/dein.toml')
  call map(dein#check_clean(), "delete(v:val, 'rf')")
  call dein#end()
  call dein#save_state()
endif
"}}}2
" 不足プラグインの自動インストール{{{2
if dein#check_install()
  call dein#install()
endif
"}}}2
"}}}1

set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set modeline
set notitle
set nowrap
set shortmess+=I
set history=10000
"set nobackup
"set noautoindent
set autoindent
set incsearch
set hlsearch
set showmatch
set tabstop=4
set shiftwidth=4
"set number
set scrolloff=6
set sidescrolloff=6
set lazyredraw
set ttyfast
syntax on
set cursorline
highlight CursorLine guibg=#0000A0 ctermbg=blue
set cursorcolumn
highlight CursorColumn guibg=#0000A0 ctermbg=blue

set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"fold options {{{1
set foldenable
set foldmethod=syntax
set foldtext=v:folddashes.substitute(getline(v:foldstart),'/\\*\\\|\\*/\\\|{{{\\d\\=','','g')
set fillchars=fold:-

autocmd InsertEnter * if !exists('w:last_fdm')
	\| let w:last_fdm=&foldmethod
	\| setlocal foldmethod=manual
	\| endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm')
	\| let &l:foldmethod=w:last_fdm
	\| unlet w:last_fdm
	\| endif

noremap [space] <nop>
  nmap <Space> [space]
noremap [space] za
"}}}1

"buffer key bind{{{1
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>
"}}}1

"command line mode key bind {{{1
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
"}}}1

" mieenai monowo miru tokoro{{{1
":set list listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
":set list listchars=tab:»-,eol:↲,extends:»,precedes:«,nbsp:%
"}}}1

"skk-vim options {{{1
"let g:skk_large_jisyo='~/.skk-dic/SKK-JISYO-utf8.L'
"let g:skk_egg_like_newline=1
"let g:skk_auto_save_jisyo=1
"let g:eskk#large_dictionary={
"	\	'path': "~/.skk-dic/SKK-JISYO-utf8.L",
"	\	'sorted': 1,
"	\	'encoding': 'utf-8',
"	\}
"	}}}1

"let g:deoplete#enable_at_startup = 1

"local setting {{{1
if filereadable(expand('~/.config/nvim/init.vim.local'))
  source ~/.config/nvim/init.vim.local
endif
"}}}1

" vim: ts=2 sw=2 sts=2 foldmethod=marker foldlevel=0 nowrap
