return {
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "williamboman/mason.nvim", lazy = false, opts = {} },
  { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-web-devicons" },
    opts = {},
    cmd = "Trouble",
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "plenary.nvim" },
    opts = {},
    cmd = "TodoTelescope",
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({})
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    ---@type ibl.config
    opts = {
      scope = {
        show_start = false,
      },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
    },
    opts = {
      filetypes = { "*", "!lazy" },
      buftype = { "*", "!prompt", "!nofile" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        tailwind = true,
        -- Available modes: foreground, background
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        virtualtext = "■",
      },
    },
  },
  {
    "github/copilot.vim",
    cmd = "Copilot",
    event = "InsertEnter",
  },
  {
    -- TODO: check this
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
