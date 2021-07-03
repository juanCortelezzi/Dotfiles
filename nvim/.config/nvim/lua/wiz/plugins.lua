return require("packer").startup(function()
	use {'wbthomason/packer.nvim'}
  use {'hoob3rt/lualine.nvim'}
  use {'tpope/vim-fugitive'}
  use {'neovim/nvim-lspconfig'}
  use {'hrsh7th/nvim-compe'}
  use {'hrsh7th/vim-vsnip'}
  use {'rafamadriz/friendly-snippets'}
  use {'glepnir/lspsaga.nvim'}
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzy-native.nvim'}
    }
  }
  use {'ThePrimeagen/harpoon'}
  use {'jiangmiao/auto-pairs'}
  use {'mhinz/vim-startify'}
  use {'tpope/vim-commentary'}
  use {'kyazdani42/nvim-web-devicons'}
  use {'sbdchd/neoformat'}
  use {'vimwiki/vimwiki'}
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {'rrethy/vim-hexokinase', run = 'make hexokinase'}
  use {'juancortelezzi/awesomecolors'}
  use {'folke/tokyonight.nvim'}
end)

-- Plug 'stevearc/vim-arduino'
-- Plug 'jpalardy/vim-slime'
