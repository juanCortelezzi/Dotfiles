return {
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "williamboman/mason.nvim",    lazy = false, opts = {} },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = { style = "moon" },
  },
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
    "github/copilot.vim",
    cmd = "Copilot",
    event = "InsertEnter",
  },
}
