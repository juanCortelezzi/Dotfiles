local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  execute("packadd packer.nvim")
end

return require("packer").startup(function(use)
  -- packer autohandles itself
  use({ "wbthomason/packer.nvim" })

  -- temporary fix
  use({ "antoinemadec/FixCursorHold.nvim" })

  -- useful for other plugins
  use({ "nvim-lua/popup.nvim" })
  use({ "nvim-lua/plenary.nvim" })

  -- Lualine statusline
  use({ "hoob3rt/lualine.nvim" })

  -- Lsp
  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("wiz.lsp")
    end,
  })

  -- Formatting with lsp
  use({ "jose-elias-alvarez/null-ls.nvim" })

  -- Completion cmp
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
    },
    config = function()
      require("wiz.cmp")
    end,
  })

  -- Vsnip snippets
  use({ "rafamadriz/friendly-snippets" })

  -- Trouble error info
  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    cmd = {
      "TroubleToggle",
    },
    config = function()
      require("trouble").setup()
    end,
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })

  -- Telescope teejdv
  use({
    "nvim-telescope/telescope.nvim",
    config = function()
      require("wiz.telescope")
    end,
    cmd = "Telescope",
    requires = {
      { "nvim-telescope/telescope-fzy-native.nvim" },
    },
  })

  -- Commentary comments
  use({
    "terrortylor/nvim-comment",
    event = "BufRead",
    cmd = "CommentToggle",
    config = function()
      require("nvim_comment").setup({
        create_mappings = false,
      })
    end,
  })

  -- Wich-key key help
  use({ "folke/which-key.nvim" })

  -- Fugitive git
  use({
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
    },
  })

  -- Autopairs
  use({
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("wiz.autopairs")
    end,
  })

  -- Harpoon the primeagen is happy
  use({ "ThePrimeagen/harpoon" })

  -- Terminal
  use({
    "akinsho/toggleterm.nvim",
    event = "BufWinEnter",
    config = function()
      require("wiz.toggleterm")
    end,
  })

  -- Icons
  use({ "kyazdani42/nvim-web-devicons" })

  -- Startify start screen
  -- REPLACE https://github.com/goolord/alpha-nvim
  use({
    "mhinz/vim-startify",
    event = "BufWinEnter",
  })

  -- VimWiki
  use({
    "vimwiki/vimwiki",
    ft = { "markdown" },
  })

  use({
    "romgrk/barbar.nvim",
    config = function()
      require("wiz.barbar")
    end,
    event = "BufWinEnter",
  })

  -- Indent line
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        show_current_context = true,
      })
    end,
  })

  -- Colorschemes
  use({ "juancortelezzi/awesomecolors" })
  use({ "LunarVim/Colorschemes" })
  use({ "folke/tokyonight.nvim" })

  -- Colorizer
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("wiz.colorizer")
    end,
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
    },
  })
end)

-- TODO:

-- Toggleterm
-- https://github.com/akinsho/toggleterm.nvim
-- BarBar
-- https://github.com/romgrk/barbar.nvim
-- TodoComments
-- https://github.com/folke/todo-comments.nvim
