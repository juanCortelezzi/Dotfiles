local nvim_lsp = require("lspconfig")
local wiz_lsp = require("wiz.lsp")

nvim_lsp.rust_analyzer.setup({
  capabilities = wiz_lsp.capabilities,
  on_attach = wiz_lsp.common_on_attach,
  settings = {
  ["rust-analyzer"] = {
    assist = {
      importGranularity = "module",
      importPrefix = "by_self",
    },
    cargo = {
      loadOutDirsFromCheck = true
    },
    procMacro = {
      enable = true
    },
  }
}})

require('wiz.utils').define_augroups({
    _rust_format = {
        {'BufWritePre', '*.rs', 'lua vim.lsp.buf.formatting_sync(nil,1000)'}
    }
})
