return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "BufReadPre",
  opts = {
    exclude = {
      buftypes = {
        "terminal",
        "nofile",
      },
      filetypes = {
        "help",
        "neo-tree",
        "Trouble",
      },
    },
    -- char = "│",
    -- use_treesitter_scope = false,
    -- show_trailing_blankline_indent = false,
    -- show_current_context = true,
  },
}
