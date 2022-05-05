-- FIX: lsp kind, has to be a better option
-- FIX: tailwind, to only open on tailwind.config projects
require("lspconfig")

-- symbols for autocomplete
-- vim.lsp.protocol.CompletionItemKind = require("wiz.lsp.kind")

require("wiz.lsp.null")
require("wiz.lsp.installer")
require("wiz.lsp.handlers").setup()
