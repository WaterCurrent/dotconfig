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
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
