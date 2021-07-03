filetype plugin on
syntax on
set hidden
set nocompatible
if (has("termguicolors"))
  set termguicolors
endif
set encoding=utf8
set shortmess+=c

" File managenemt
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.config/nvim/undodir
set undofile
set clipboard=unnamedplus

" Identation
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set colorcolumn=81
set textwidth=80

" Search 
set smartcase
set nohlsearch
set incsearch
set completeopt=menuone,noselect

" Text rendering
set nowrap
set re=0

" Numbers
set number
set relativenumber
set numberwidth=1

" User interface
set showcmd
set mouse=
set showmatch
set ruler
set noerrorbells
set laststatus=2
set cmdheight=1
set signcolumn=number
set noshowmode
set cursorline
set scrolloff=4
set updatetime=50
set background=dark
set splitright
