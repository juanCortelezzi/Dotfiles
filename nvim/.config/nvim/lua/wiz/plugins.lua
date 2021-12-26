local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.api.nvim_command("packadd packer.nvim")
end

require("packer").startup({
  function(use)
    -- packer autohandles itself
    use("wbthomason/packer.nvim")
    use("lewis6991/impatient.nvim")
    use("antoinemadec/FixCursorHold.nvim") -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
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
    use("jose-elias-alvarez/null-ls.nvim")

    -- Rust lsp
    use("simrat39/rust-tools.nvim")

    -- Completion cmp and snippets luasnip
    use({
      "L3MON4D3/LuaSnip",
      module = "luasnip",
      config = function()
        require("luasnip/loaders/from_vscode").load()
      end,
      requires = "rafamadriz/friendly-snippets",
    })

    use({
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      config = function()
        require("wiz.cmp")
      end,
      requires = {
        "L3MON4D3/LuaSnip",
      },
    })

    use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp", module = "cmp_nvim_lsp" })
    use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-path", after = "nvim-cmp" })

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
        require("wiz.telescope")
      end,
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

    -- Harpoon the primeagen is happy
    use("ThePrimeagen/harpoon")

    -- Terminal
    use({
      "akinsho/toggleterm.nvim",
      event = "BufWinEnter",
      config = function()
        require("wiz.toggleterm")
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

    -- Barbar navbar buffers
    -- use({
    --   "romgrk/barbar.nvim",
    --   event = "BufWinEnter",
    --   config = function()
    --     require("wiz.barbar")
    --   end,
    -- })

    -- Indent line
    use({
      "lukas-reineke/indent-blankline.nvim",
      event = "BufWinEnter",
      config = function()
        require("indent_blankline").setup({
          show_current_context = true,
          buftype_exclude = { "terminal", "startify", "markdown", "nofile" },
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
        require("wiz.colorizer")
      end,
    })

    -- Wich-key key help
    use({
      "folke/which-key.nvim",
      config = function()
        require("wiz.whichkey")
      end,
    })

    -- Colorschemes
    use("~/Documents/Random-programes/awesomecolors")
    use("folke/tokyonight.nvim")
    use({ "rose-pine/neovim", as = "rose-pine" })
  end,
  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  },
})

require("packer_compiled")
