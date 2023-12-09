return {
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = { style = "moon" },
  },
  { "numToStr/Comment.nvim", event = "VeryLazy", config = true },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-web-devicons" },
    config = true,
    cmd = "Trouble",
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
  { "williamboman/mason.nvim", lazy = false, config = true },
}
