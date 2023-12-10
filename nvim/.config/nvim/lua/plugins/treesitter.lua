---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
      opts = {},
    },
    {
      "windwp/nvim-ts-autotag",
      event = "VeryLazy",
      opts = {},
    },
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      opts = {},
    },
  },
  config = function()
    vim.defer_fn(function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
        highlight = { enable = true },
        indent = { enable = true },
        ts_context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        autotag = { enable = true },
        autopairs = { enable = true },
      })
    end, 0)
  end,
}
