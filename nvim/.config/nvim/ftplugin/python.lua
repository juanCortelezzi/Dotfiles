local nvim_lsp = require("lspconfig")
local wiz_lsp = require("wiz.lsp")

nvim_lsp.pyright.setup({
  capabilities = lsp_config.capabilities,
  on_attatch = wiz_lsp.common_on_attatch
})

require('wiz.utils').define_augroups({
    _python_autoformat = {
        {
            'BufWritePre', '*.py',
            'lua vim.lsp.buf.formatting_sync(nil, 1000)'
        }
    }
})
