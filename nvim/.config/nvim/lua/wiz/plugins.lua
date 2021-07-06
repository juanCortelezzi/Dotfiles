return require('packer').startup(function(use)

  -- packer autohandles itself
	use {'wbthomason/packer.nvim'}

  -- to use lua ft plugins TEMPORARY FIX
  use {'tjdevries/astronauta.nvim'}

  -- useful for other plugins
  use {'nvim-lua/popup.nvim'}
  use {'nvim-lua/plenary.nvim'}

  -- statusline
  use {'hoob3rt/lualine.nvim'}

  -- git
  use {
    'tpope/vim-fugitive',
    cmd ={
      'G',
      'Git'
    }
  }

  -- lsp
  use {'neovim/nvim-lspconfig'}

  use {
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    config = function()
      require("wiz.compe")
    end,
  }

  use {'glepnir/lspsaga.nvim'}

  -- snippets
  use {
    'hrsh7th/vim-vsnip',
    event = "InsertEnter",
    requires = {
      {'rafamadriz/friendly-snippets', event = "InsertEnter"}
    }
  }

  -- telescopic jhonson teejdv
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-telescope/telescope-fzy-native.nvim'}
    }
  }

  -- harpoon the primeagen is happy
  use {'ThePrimeagen/harpoon'}

  -- autoformat
  use {'kyazdani42/nvim-web-devicons'}

  use {'mhinz/vim-startify'}

  use {'tpope/vim-commentary'}

  use {
    'sbdchd/neoformat',
    ft = {'ts', 'tsx', 'js', 'jsx', 'html', 'css', 'scss', 'json'},
    event = "BufEnter"
  }

  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    after = { "telescope.nvim", "nvim-compe" },
    config = function()
      require("wiz.autopairs")
    end,
  }

  use {
    'vimwiki/vimwiki',
    ft = {'markdown'}
  }

  -- colorschemes
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {'juancortelezzi/awesomecolors'}

  use {'folke/tokyonight.nvim'}

  use {
    'rrethy/vim-hexokinase',
    run = 'make hexokinase',
    ft = {'css', 'scss', 'html', 'tsx'}
  }

end)

-- Plug 'stevearc/vim-arduino'
-- Plug 'jpalardy/vim-slime'
