local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  print("could not load packer")
  return
end

packer.init({
  -- Move to lua dir so impatient.nvim can cache it
  compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use({ "wbthomason/packer.nvim" })
  use({ "lewis6991/impatient.nvim" })

  -- useful for other plugins
  use({ "nvim-lua/plenary.nvim" })
  -- Icons
  use({ "kyazdani42/nvim-web-devicons" })

  use({ "goolord/alpha-nvim" })

  -- Lualine statusline
  use({ "nvim-lualine/lualine.nvim" })

  -- Indent line
  use({ "lukas-reineke/indent-blankline.nvim" })

  -- File tree
  use({ "kyazdani42/nvim-tree.lua" })

  -- Terminal
  use({ "akinsho/toggleterm.nvim" })

  -- Comments
  use({ "numToStr/Comment.nvim" })
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })

  -- Autopairs
  use({ "windwp/nvim-autopairs" })

  -- Colorschemes
  use({ "folke/tokyonight.nvim" })
  use({ "rose-pine/neovim", as = "rose-pine" })
  use({ "olivercederborg/poimandres.nvim" })
  use({ "catppuccin/nvim", as = "catppuccin" })

  -- cmp plugins
  use({ "hrsh7th/nvim-cmp" })
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-path" })
  use({ "saadparwaiz1/cmp_luasnip" })
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-nvim-lua" })

  -- snippets
  use({ "L3MON4D3/LuaSnip" })
  use({ "rafamadriz/friendly-snippets" })

  -- LSP
  use({
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "simrat39/rust-tools.nvim",
  })

  -- Harpoon the primeagen is happy
  use("ThePrimeagen/harpoon")

  -- Telescope
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  })
  use({ "nvim-telescope/telescope.nvim" })

  -- Trouble error and todo info
  use({
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "TodoTrouble" },
    config = function()
      require("trouble").setup()
    end,
  })

  use("folke/todo-comments.nvim")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use({
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup()
    end,
  })

  use({ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" })

  -- DAP
  --[[ use({ "mfussenegger/nvim-dap" }) ]]
  --[[ use({ "rcarriga/nvim-dap-ui" }) ]]
  --[[ use({ "ravenxrz/DAPInstall.nvim" }) ]]

  -- VimWiki
  use({
    "vimwiki/vimwiki",
    ft = "markdown",
  })

  -- Neorg
  use({
    "nvim-neorg/neorg",
    requires = "nvim-lua/plenary.nvim",
  })

  -- Colorizer
  use({
    "norcalli/nvim-colorizer.lua",
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
    },
  })

  -- Twilight
  use({
    "folke/twilight.nvim",
    cmd = { "Twilight" },
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
