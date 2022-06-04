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
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]])

local ok, packer = pcall(require, "packer")
if not ok then
  print("error when loading packer")
  return
end

packer.startup({
  function(use)
    -- packer autohandles itself
    use("wbthomason/packer.nvim")
    use("williamboman/nvim-lsp-installer")
    use("lewis6991/impatient.nvim")
    -- use("antoinemadec/FixCursorHold.nvim") -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
    use({ "tweekmonster/startuptime.vim", cmd = "StartupTime" })

    -- useful for other plugins
    use({ "nvim-lua/popup.nvim", module = "popup" })
    use({ "nvim-lua/plenary.nvim", module = "plenary" })

    -- Icons
    use({ "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" })

    -- Lualine statusline
    use({
      "nvim-lualine/lualine.nvim",
      config = function()
        require("wiz.statusline")
      end,
    })

    -- Lsp
    use("jose-elias-alvarez/null-ls.nvim")
    use({ "simrat39/rust-tools.nvim", module = "rust-tools" })
    use({
      "neovim/nvim-lspconfig",
      config = function()
        require("wiz.lsp")
      end,
    })

    -- Completion cmp and snippets luasnip
    use({
      "L3MON4D3/LuaSnip",
      module = "luasnip",
      requires = "rafamadriz/friendly-snippets",
    })

    use({
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      config = function()
        require("wiz.completion")
      end,
      requires = {
        "L3MON4D3/LuaSnip",
      },
    })

    use({ after = "nvim-cmp", "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" })
    use({ after = "nvim-cmp", "saadparwaiz1/cmp_luasnip" })
    use({ after = "nvim-cmp", "hrsh7th/cmp-buffer" })
    use({ after = "nvim-cmp", "hrsh7th/cmp-nvim-lua" })
    use({ after = "nvim-cmp", "hrsh7th/cmp-cmdline" })
    use({ after = "nvim-cmp", "hrsh7th/cmp-path" })

    -- Autopairs
    use({
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function()
        require("wiz.autopairs")
      end,
    })

    -- Trouble error info
    use({
      "folke/trouble.nvim",
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

    use({ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" })

    -- Telescope tj-devries
    use({
      "ahmedkhalf/project.nvim",
      after = "telescope.nvim",
      config = function()
        require("wiz.project")
        require("telescope").load_extension("projects")
      end,
      requires = "telescope.nvim",
    })

    use({
      "nvim-telescope/telescope-fzf-native.nvim",
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("fzf")
      end,
      run = "make",
      requires = "telescope.nvim",
    })

    use({
      "nvim-telescope/telescope.nvim",
      module = "telescope",
      cmd = "Telescope",
      config = function()
        require("wiz.telescopic")
      end,
    })

    -- Comments
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("wiz.comments")
      end,
    })

    -- Harpoon the primeagen is happy
    use("ThePrimeagen/harpoon")

    -- Terminal
    use({
      "akinsho/toggleterm.nvim",
      event = "BufWinEnter",
      config = function()
        require("wiz.terminal")
      end,
    })

    use({
      "kyazdani42/nvim-tree.lua",
      cmd = {
        "NvimTreeToggle",
        "NvimTreeRefresh",
      },
      config = function()
        require("wiz.nvimtree")
      end,
      requires = "kyazdani42/nvim-web-devicons",
    })

    -- TodoComments
    use({
      "folke/todo-comments.nvim",
      cmd = "TodoTrouble",
      config = function()
        require("wiz.todocomments")
      end,
    })

    -- Startify start screen
    use({
      "goolord/alpha-nvim",
      config = function()
        require("wiz.alphanvim")
      end,
    })

    -- VimWiki
    use({
      "vimwiki/vimwiki",
      ft = "markdown",
      config = function()
        require("wiz.vimwiki")
      end,
    })

    -- Neorg
    use({
      "nvim-neorg/neorg",
      config = function()
        require("wiz.neorg")
      end,
      requires = "nvim-lua/plenary.nvim",
    })

    -- Indent line
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("indent_blankline").setup({
          show_current_context = true,
          buftype_exclude = { "terminal", "startify", "markdown", "norg", "nofile" },
        })
      end,
    })

    -- Colorizer
    use({
      "norcalli/nvim-colorizer.lua",
      cmd = {
        "ColorizerAttachToBuffer",
        "ColorizerDetachFromBuffer",
        "ColorizerReloadAllBuffers",
      },
      config = function()
        require("wiz.hexcolors")
      end,
    })

    -- Wich-key key help
    use({
      "folke/which-key.nvim",
      config = function()
        require("wiz.whichkey")
      end,
    })

    -- Twilight
    use({
      "folke/twilight.nvim",
      cmd = { "Twilight" },
      config = function()
        require("wiz.twilight")
      end,
    })

    -- Colorschemes
    use("folke/tokyonight.nvim")
    use({ "rose-pine/neovim", as = "rose-pine" })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end,
  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  },
})

require("packer_compiled")
