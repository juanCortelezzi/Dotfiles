---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-tree/nvim-web-devicons", optional = true },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  opts = {
    extensions = {
      fzf = {},
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
  end,
  keys = {
    {
      "<leader>f",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Telescope find files",
    },
    {
      "<leader>g",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Telescope live grep",
    },
    {
      "<leader>h",
      function()
        require("telescope.builtin").help_tags()
      end,
      desc = "Telescope help tags",
    },
    {
      "<leader>tt",
      function()
        require("telescope.builtin").builtin()
      end,
      desc = "Telescope builtins",
    },
    {
      "<leader>en",
      function()
        require("telescope.builtin").find_files({
          cwd = vim.fn.stdpath("config"),
        })
      end,
      desc = "Telescope edit neovim files",
    },
  },
}
