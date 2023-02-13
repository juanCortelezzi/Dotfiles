return {
  Lua = {
    completion = {
      callSnippet = "Replace",
    },
    -- runtime = {
    --   -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
    --   version = 'LuaJIT',
    --   -- Setup your lua path
    --   path = vim.split(package.path, ';'),
    -- },
    diagnostics = {
      globals = { "vim" },
    },
    workspace = {
      library = {
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        -- [vim.fn.stdpath "config" .. "/lua"] = true,
      },
      -- maxPreload = 10000,
    },
    telemetry = {
      enable = false,
    },
  },
}
