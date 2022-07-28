local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  print("could not load null-ls")
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity
null_ls.setup({
  debug = false,
  sources = {
    -- js, ts, json
    formatting.prettier.with({
      extra_filetypes = { "toml", "solidity" },
    }),
    -- python
    formatting.black.with({ extra_args = { "--fast" } }),
    -- diagnostics.flake8,
    -- lua
    null_ls.builtins.formatting.stylua.with({
      extra_args = { "--config-path", vim.fn.stdpath("config") .. "/stylua.toml" },
    }),
    -- golang
    null_ls.builtins.formatting.gofmt,
    -- rust
    null_ls.builtins.formatting.rustfmt,
    -- bash
    -- null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.beautysh.with({
      extra_args = { "--indent-size", 2 },
    }),
    -- zig
    null_ls.builtins.formatting.zigfmt,
  },
})
