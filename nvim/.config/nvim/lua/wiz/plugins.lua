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
  use({
    "hoob3rt/lualine.nvim",
    config = function()
      require("wiz.lualine")
    end,
  })

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
      "rafamadriz/friendly-snippets",
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

  -- Trouble error info
  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    cmd = { "TroubleToggle" },
    config = function()
      require("trouble").setup()
    end,
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("wiz.treesitter")
    end,
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
      {
        "ahmedkhalf/project.nvim",
        config = function()
          require("wiz.project")
        end,
      },
    },
  })

  -- Commentary comments
  use({
    "terrortylor/nvim-comment",
    cmd = "CommentToggle",
    config = function()
      require("nvim_comment").setup({
        create_mappings = false,
      })
    end,
  })

  -- Wich-key key help
  use({ "folke/which-key.nvim" })

  -- Autopairs
  use({
    "windwp/nvim-autopairs",
    event = "InsertEnter",
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

  -- TodoComments
  use({
    "folke/todo-comments.nvim",
    cmd = {
      "TodoTrouble",
    },
    config = function()
      require("wiz.todocomments")
    end,
  })

  -- Icons
  use({ "kyazdani42/nvim-web-devicons" })

  -- Startify start screen
  use({
    "goolord/alpha-nvim",
    config = function()
      require("wiz.alphanvim")
    end,
  })

  use({
    "simrat39/rust-tools.nvim",
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
        buftype_exclude = { "terminal", "startify", "markdown", "nofile" },
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
