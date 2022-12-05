local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  print("could not load null-ls")
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
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
      extra_args = { "--config-path", vim.fn.stdpath("config") .. "/stylua.toml" },
    }),
    -- golang
    formatting.gofmt,
    -- rust
    formatting.rustfmt.with({
      extra_args = { "--edition", 2021 },
    }),
    -- bash
    -- null_ls.builtins.diagnostics.shellcheck,
    formatting.beautysh.with({
      extra_args = { "--indent-size", 2 },
    }),
    -- zig
    formatting.zigfmt,
  },
})
