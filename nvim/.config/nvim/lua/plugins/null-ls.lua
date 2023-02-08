local M = {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  --   has_formatter = function(ft)
  --     local sources = require("null-ls.sources")
  --     local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  --     return #available > 0
  --   end,
}

function M.setup(on_attach)
  local null_ls = require("null-ls")
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  local formatting = null_ls.builtins.formatting

  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  -- local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup({
    debug = false,
    debounce = 150,
    on_attach = on_attach,
    sources = {
      -- js, ts, json
      formatting.prettier.with({
        extra_filetypes = { "toml", "astro" },
      }),
      -- python
      formatting.black.with({ extra_args = { "--fast" } }),
      -- diagnostics.flake8,
      -- lua
      formatting.stylua.with({
        extra_args = {
          "--config-path",
          vim.fn.stdpath("config") .. "/stylua.toml",
        },
      }),
      -- golang
      -- formatting.gofmt,
      formatting.gofumpt.with({
        extra_args = { "--extra" },
        env = {
          GOFUMPT_SPLIT_LONG_LINES = "on",
        },
      }),
      -- rust
      formatting.rustfmt.with({
        extra_args = { "--edition", 2021 },
      }),
      -- bash
      null_ls.builtins.diagnostics.shellcheck,
      formatting.beautysh.with({
        extra_args = { "--indent-size", 2 },
      }),
      -- zig
      formatting.zigfmt,
    },
  })
end

return M
