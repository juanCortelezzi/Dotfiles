-- FIX: lsp kind, has to be a better option
-- FIX: tailwind, to only open on tailwind.config projects
--LSP Config
local null_ls = require("null-ls")
local lsp_config = require("wiz.lsp.handlers")

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = require("wiz.lsp.kind")

require("wiz.lsp.installer")
lsp_config.setup()

-- lspconfig["tailwindcss"].setup({
--   capabilities = lsp_config.capabilities,
--   on_attach = lsp_config.common_on_attach,
--   cmd = {
--     lang_servers_path .. "/tailwind/node_modules/@tailwindcss/language-server/bin/tailwindcss-language-server",
--     "--stdio",
--   },
--   filetypes = {
--     "html",
--     "markdown",
--     "mdx",
--     "css",
--     "postcss",
--     "javascript",
--     "javascriptreact",
--     "typescript",
--     "typescriptreact",
--   },
--   root_dir = util.root_pattern(".git", "tailwind.config.js", "tailwind.config.ts"),
-- })

-- lspconfig["emmet_ls"].setup({
--   capabilities = lsp_config.capabilities,
--   on_attach = lsp_config.common_on_attach,
--   cmd = { lang_servers_path .. "/emmet/node_modules/emmet-ls/out/server.js", "--stdio" },
--   filetypes = { "html" },
--   root_dir = util.root_pattern("package.json", ".git"),
-- })
--
-- local rust_analyzer_path = lang_servers_path .. "/rust/rust-analyzer-x86_64-unknown-linux-gnu"
--
-- require("rust-tools").setup({
--   tools = {
--     autoSetHints = true,
--     hover_with_actions = true,
--     inlay_hints = {
--       show_parameter_hints = false,
--       parameter_hints_prefix = "",
--       other_hints_prefix = "",
--     },
--   },
--
--   server = {
--     capabilities = lsp_config.capabilities,
--     on_attach = lsp_config.common_on_attach,
--     cmd = { rust_analyzer_path },
--     settings = {
--       ["rust-analyzer"] = {
--         assist = {
--           importGranularity = "module",
--           importPrefix = "by_self",
--         },
--         cargo = {
--           loadOutDirsFromCheck = true,
--         },
--         procMacro = {
--           enable = true,
--         },
--         checkOnSave = {
--           command = "clippy",
--         },
--       },
--     },
--   },
-- })

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
