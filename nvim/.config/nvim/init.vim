call plug#begin('~/.config/nvim/plugged')

" status line 
Plug 'hoob3rt/lualine.nvim'
" git
Plug 'tpope/vim-fugitive', {'on': 'G'}
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'glepnir/lspsaga.nvim'
" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
" harpoon ThePrimeagen is happy
 Plug 'ThePrimeagen/harpoon'
" autopair
Plug 'jiangmiao/auto-pairs'
" startify
Plug 'mhinz/vim-startify'
" comments
Plug 'tpope/vim-commentary' 
" vim icons
Plug 'kyazdani42/nvim-web-devicons'
" prettier
Plug 'sbdchd/neoformat', {'for': ['javascript', 'typescript', 'html', 'css']}
" vim wiki
Plug 'vimwiki/vimwiki', {'for': ['markdown', 'wiki']}
" color schemes
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase', 'for': ['javascript', 'typescript', 'html', 'css']}
Plug 'juancortelezzi/awesomecolors'
Plug 'folke/tokyonight.nvim'

" arduino
" Plug 'stevearc/vim-arduino'
" Plug 'jpalardy/vim-slime'

call plug#end()

" let g:tokyonight_style = "night"
" let g:tokyonight_italic_functions = 1
" let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]
" let g:tokyonight_transparent = "true"

colorscheme nord

" require all lua configs 
lua require('wiz')

function! Wiki()
    colorscheme gruvbox
    set tw=60
    set colorcolumn=61
endfunction
