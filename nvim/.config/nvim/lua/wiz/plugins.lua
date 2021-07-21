local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

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

  -- Lsp
  use {'neovim/nvim-lspconfig'}

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

  -- Compe completion
  use {
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    config = function()
      require("wiz.compe")
    end,
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Telescope teejdv
  use {
    'nvim-telescope/telescope.nvim',
    config = [[require('wiz.telescope')]],
    cmd = "Telescope",
    requires = {
      {'nvim-telescope/telescope-fzy-native.nvim'}
    }
  }

  -- Commentary comments
  use {
    "terrortylor/nvim-comment",
    cmd = "CommentToggle",
    config = function()
      require("nvim_comment").setup({create_mappings = false})
    end,
  }

  -- Wich-key key help
  use { "folke/which-key.nvim" }

  -- Fugitive git
  use {
    'tpope/vim-fugitive',
    cmd ={
      'G',
      'Git'
    }
  }

  -- Autopairs
  use {
    "windwp/nvim-autopairs",
    after = { "nvim-compe", "nvim-treesitter" },
    config = function ()
        print("calling autopairs")
        require("wiz.autopairs")
    end,
  }

  -- Harpoon the primeagen is happy
  use {'ThePrimeagen/harpoon'}

  -- Neoformat autoformat
  use {
    'sbdchd/neoformat',
    ft = {'ts', 'tsx', 'js', 'jsx', 'html', 'css', 'scss', 'json'},
    event = "BufEnter"
  }

  -- Icons
  use {'kyazdani42/nvim-web-devicons'}

  -- Startify start screen
  use {'mhinz/vim-startify'}

  -- VimWiki
  use {
    'vimwiki/vimwiki',
    ft = {'markdown'}
  }

  -- Colorschemes
  use {'juancortelezzi/awesomecolors'}

  -- Colorizer
  use {
    "norcalli/nvim-colorizer.lua",
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
    },
    config = [[require("wiz.colorizer")]]
  }
end)

-- Plug 'stevearc/vim-arduino'
-- Plug 'jpalardy/vim-slime'
