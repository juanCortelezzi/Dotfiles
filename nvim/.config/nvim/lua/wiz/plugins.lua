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

packer.init {
  -- Move to lua dir so impatient.nvim can cache it
  compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(
  function(use)
    -- My plugins here
    use({ "wbthomason/packer.nvim" })
    use({ "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" })

    -- useful for other plugins
    use({ "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" })
    -- Icons
    use({ "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" })

    use({ "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" })

    -- Lualine statusline
    use({ "nvim-lualine/lualine.nvim", commit = "3362b28f917acc37538b1047f187ff1b5645ecdd" })

    -- Indent line
    use({ "lukas-reineke/indent-blankline.nvim", commit = "6177a59552e35dfb69e1493fd68194e673dc3ee2" })

    -- File tree
    use({ "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" })

    -- Terminal
    use({ "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" })

    -- Comments
    use({ "numToStr/Comment.nvim", commit = "2c26a00f32b190390b664e56e32fd5347613b9e2" })
    use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269" })

    -- Autopairs
    use({ "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" })

    -- Colorschemes
    use({ "folke/tokyonight.nvim", commit = "8223c970677e4d88c9b6b6d81bda23daf11062bb" })
    use({ "rose-pine/neovim", as = "rose-pine" })

    -- cmp plugins
    use({ "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" })
    use({ "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" })
    use({ "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" })
    use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" })
    use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
    use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

    -- snippets
    use({ "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" })
    use({ "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" })

    -- LSP
    use({ "neovim/nvim-lspconfig" })
    use({ "williamboman/nvim-lsp-installer" })
    use({ "jose-elias-alvarez/null-ls.nvim" })
    use({ "simrat39/rust-tools.nvim", module = "rust-tools" })

    -- Harpoon the primeagen is happy
    use("ThePrimeagen/harpoon")

    -- Telescope
    use({
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
    })
    use({ "nvim-telescope/telescope.nvim", commit = "d96eaa914aab6cfc4adccb34af421bdd496468b0" })

    -- Trouble error and todo info
    use({
      "folke/trouble.nvim",
      config = function()
        require("trouble").setup()
      end,
    })

    use("folke/todo-comments.nvim")

    -- Treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      commit = "518e27589c0463af15463c9d675c65e464efc2fe",
      run = ":TSUpdate",
    })

    use({ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" })

    -- DAP
    use({ "mfussenegger/nvim-dap", commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d" })
    use({ "rcarriga/nvim-dap-ui", commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7" })
    use({ "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" })

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
  end
)
