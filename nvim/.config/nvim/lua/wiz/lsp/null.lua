local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- js, ts, json
    null_ls.builtins.formatting.prettier,
    -- python
    null_ls.builtins.formatting.black,
    -- golang
    null_ls.builtins.formatting.gofmt,
    -- rust
    null_ls.builtins.formatting.rustfmt,
    -- bash
    null_ls.builtins.diagnostics.shellcheck,
    -- lua
    null_ls.builtins.formatting.stylua.with({
      extra_args = { "--config-path", vim.fn.stdpath("config") .. "/stylua.toml" },
    }),
  },
})
