--LSP Config
local null_ls = require("null-ls")
local lspconfig = require("lspconfig")
local lsp_config = {}

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = require("wiz.lsp.kind")

lsp_config.capabilities = vim.lsp.protocol.make_client_capabilities()
-- add snippet support
lsp_config.capabilities.textDocument.completion.completionItem.snippetSupport = true

function lsp_config.common_on_attach(client)
  require("wiz.lsp.dochighlight").lsp_highlight_document(client)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
  vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]])
end

lspconfig["tsserver"].setup({
  capabilities = lsp_config.capabilities,
  on_attach = lsp_config.common_on_attach,
})

lspconfig["gopls"].setup({
  capabilities = lsp_config.capabilities,
  on_attach = lsp_config.common_on_attach,
})

lspconfig["pyright"].setup({
  capabilities = lsp_config.capabilities,
  on_attach = lsp_config.common_on_attach,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
        typeCheckingMode = "basic",
      },
    },
  },
})

local lang_serevers_path = vim.fn.stdpath("config") .. "/lang-servers"
local sumneko_root_path = lang_serevers_path .. "/lua/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig["sumneko_lua"].setup({
  capabilities = lsp_config.capabilities,
  on_attach = lsp_config.common_on_attach,
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = runtime_path,
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
        maxPreload = 10000,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

null_ls.config({
  sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.stylua.with({
      extra_args = { "--config-path", lang_serevers_path .. "/lua/stylua.toml" },
    }),
  },
})

lspconfig["null-ls"].setup({
  autostart = true,
})

-- local nvim_lsp = require("lspconfig")
-- local wiz_lsp = require("wiz.lsp")
-- nvim_lsp.rust_analyzer.setup({
--   capabilities = wiz_lsp.capabilities,
--   on_attach = wiz_lsp.common_on_attach,
--   settings = {
--   ["rust-analyzer"] = {
--     assist = {
--       importGranularity = "module",
--       importPrefix = "by_self",
--     },
--     cargo = {
--       loadOutDirsFromCheck = true
--     },
--     procMacro = {
--       enable = true
--     },
--   }
-- }})
