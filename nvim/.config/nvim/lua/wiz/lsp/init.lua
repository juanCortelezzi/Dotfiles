--LSP Config
local lspconfig = require('lspconfig')
local lsp_config = {}

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = require("wiz.lsp.kinds")

lsp_config.capabilities = vim.lsp.protocol.make_client_capabilities()
-- add snippet support
lsp_config.capabilities.textDocument.completion.completionItem.snippetSupport = true

function lsp_config.common_on_attach(client)
    require("wiz.lsp.dochighlight").lsp_highlight_document(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    vim.cmd[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
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
                typeCheckingMode = "basic"
            }
        }
    }
})

-- local nvim_lsp = require("lspconfig")
-- local wiz_lsp = require("wiz.lsp")
-- 
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
--
--
--
--
-- local system_name = "Linux"
-- local sumneko_root_path = "/home/wiz/.config/nvim/lang-servers/lua-language-server"
-- local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
-- 
-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")
-- 
-- require'lspconfig'.sumneko_lua.setup {
--   cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--         -- Setup your lua path
--         path = runtime_path,
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = {'vim'},
--       },
--       workspace = {
--           -- Make the server aware of Neovim runtime files
--           library = {
--               [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--               [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
--           },
--           maxPreload = 10000,
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- }
