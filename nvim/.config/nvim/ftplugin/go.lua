local nvim_lsp = require("lspconfig")
local wiz_lsp = require("wiz.lsp")

nvim_lsp.gopls.setup({
  capabilities = require("wiz.lsp").capabilities,
  on_attatch = wiz_lsp.common_on_attatch
})

require('wiz.utils').define_augroups({
  _go = {
    -- Go generally requires Tabs instead of spaces.
    {'BufWritePre', '*.go', 'lua vim.lsp.buf.formatting_sync(nil,1000)'},
    {'FileType', 'go', 'setlocal tabstop=4'},
    {'FileType', 'go', 'setlocal shiftwidth=4'},
    {'FileType', 'go', 'setlocal softtabstop=4'},
    {'FileType', 'go', 'setlocal noexpandtab'}
  }
})
