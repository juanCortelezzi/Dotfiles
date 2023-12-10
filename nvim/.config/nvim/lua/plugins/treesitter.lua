---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  build = ":TSUpdate",
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treeitter** module to be loaded in time.
    -- Luckily, the only thins that those plugins need are the custom queries, which we make available
    -- during startup.
    --
    -- this is stolen from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua
    -- aka folke's lazyvim
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  dependencies = {
    { "JoosepAlviste/nvim-ts-context-commentstring", opts = {} },
    { "windwp/nvim-ts-autotag", opts = {} },
    { "windwp/nvim-autopairs", opts = {} },
  },
  config = function()
    vim.defer_fn(function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "go",
          "javascript",
          "typescript",
          "tsx",
          "json",
          "rust",
          "zig",
          "ocaml",
          "python",
        },
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
