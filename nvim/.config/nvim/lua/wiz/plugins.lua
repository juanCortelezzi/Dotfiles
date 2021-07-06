return require('packer').startup(function(use)

  -- packer autohandles itself
	use {'wbthomason/packer.nvim'}

  -- to use lua ft plugins TEMPORARY FIX
  use {'tjdevries/astronauta.nvim'}

  -- useful for other plugins
  use {'nvim-lua/popup.nvim'}
  use {'nvim-lua/plenary.nvim'}

  -- Lualine statusline
  use {'hoob3rt/lualine.nvim'}

  -- Fugitive git
  use {
    'tpope/vim-fugitive',
    cmd ={
      'G',
      'Git'
    }
  }

  -- Lsp
  use {'neovim/nvim-lspconfig'}

  -- Compe completion
  use {
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    config = function()
      require("wiz.compe")
    end,
  }

  -- LspSaga lsp stuff
  -- TODO: remove saga, maby not that useful
  use {'glepnir/lspsaga.nvim'}

  -- Vsnip snippets
  use {
    'hrsh7th/vim-vsnip',
    event = "InsertEnter",
    requires = {
      {'rafamadriz/friendly-snippets', event = "InsertEnter"}
    }
  }

  -- Telescope teejdv
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-telescope/telescope-fzy-native.nvim'}
    }
  }

  -- Harpoon the primeagen is happy
  use {'ThePrimeagen/harpoon'}

  -- Icons
  use {'kyazdani42/nvim-web-devicons'}

  -- Startify start screen
  use {'mhinz/vim-startify'}

  -- Commentary comments
  use {
    "terrortylor/nvim-comment",
    cmd = "CommentToggle",
    config = function()
      require("nvim_comment").setup()
    end,
  }

  -- Neoformat autoformat
  use {
    'sbdchd/neoformat',
    ft = {'ts', 'tsx', 'js', 'jsx', 'html', 'css', 'scss', 'json'},
    event = "BufEnter"
  }

  -- Autopairs
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    after = { "telescope.nvim", "nvim-compe" },
    config = function()
      require("wiz.autopairs")
    end,
  }

  -- VimWiki
  use {
    'vimwiki/vimwiki',
    ft = {'markdown'}
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Colorschemes
  use {'juancortelezzi/awesomecolors'}

  use {'folke/tokyonight.nvim'}
end)

-- Plug 'stevearc/vim-arduino'
-- Plug 'jpalardy/vim-slime'
