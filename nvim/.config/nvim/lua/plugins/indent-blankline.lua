return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "BufReadPre",
  opts = {
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = {
      "help",
      "neo-tree",
      "Trouble",
    },
    -- char = "│",
    -- use_treesitter_scope = false,
    -- show_trailing_blankline_indent = false,
    -- show_current_context = true,
  },
}
