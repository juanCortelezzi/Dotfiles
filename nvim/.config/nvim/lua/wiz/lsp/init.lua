-- FIX: lsp kind, has to be a better option
-- FIX: tailwind, to only open on tailwind.config projects
require("lspconfig")
--
-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = require("wiz.lsp.kind")

require("wiz.lsp.null")
require("wiz.lsp.installer")
require("wiz.lsp.handlers").setup()

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
