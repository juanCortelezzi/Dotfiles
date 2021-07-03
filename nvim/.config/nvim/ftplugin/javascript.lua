local nvim_lsp = require("lspconfig")
local wiz_lsp = require("wiz.lsp")

nvim_lsp.tsserver.setup({
  capabilities = wiz_lsp.capabilities,
  on_attatch = wiz_lsp.tsserver_on_attatch,
  filetypes = {
      "javascript", "javascriptreact", "javascript.jsx", "typescript",
      "typescriptreact", "typescript.tsx"
  },
  root_dir = require('lspconfig/util').root_pattern(
    "package.json",
    "tsconfig.json",
    "jsconfig.json",
    ".git"
  ),
})

require('wiz.utils').define_augroups({
    _javascript_autoformat = {
        {
            'BufWritePre', '*.js',
            'lua vim.lsp.buf.formatting_sync(nil, 1000)'
        }
    },
    _javascriptreact_autoformat = {
        {
            'BufWritePre', '*.jsx',
            'lua vim.lsp.buf.formatting_sync(nil, 1000)'
        }
    },
    _typescript_autoformat = {
        {
            'BufWritePre', '*.ts',
            'lua vim.lsp.buf.formatting_sync(nil, 1000)'
        }
    },
    _typescriptreact_autoformat = {
        {
            'BufWritePre', '*.tsx',
            'lua vim.lsp.buf.formatting_sync(nil, 1000)'
        }
    }
})

vim.cmd("setl ts=2 sw=2")
