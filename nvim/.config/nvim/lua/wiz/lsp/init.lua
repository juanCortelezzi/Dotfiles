--LSP Config
local null_ls = require("null-ls")
local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local lsp_config = {}

local config = {
  signs = {
    active = true,
    values = {
      { name = "DiagnosticSignError", text = "" },
      { name = "DiagnosticSignWarn", text = "" },
      { name = "DiagnosticSignHint", text = "" },
      { name = "DiagnosticSignInfo", text = "" },
    },
  },

  virtual_text = {
    prefix = "",
    spacing = 0,
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

for _, sign in ipairs(config.signs.values) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = require("wiz.lsp.kind")

local function make_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return require("cmp_nvim_lsp").update_capabilities(capabilities)
end

lsp_config.capabilities = make_capabilities()

function lsp_config.common_on_attach(client)
  require("wiz.lsp.dochighlight").lsp_highlight_document(client)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
  vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 2000)]])
end

local lang_servers_path = vim.fn.stdpath("config") .. "/lang-servers"

lspconfig["tsserver"].setup({
  capabilities = lsp_config.capabilities,
  on_attach = lsp_config.common_on_attach,
  cmd = { lang_servers_path .. "/typescript/node_modules/typescript-language-server/lib/cli.js", "--stdio" },
})

local vs_lang_server_path = lang_servers_path .. "/htmlcss/node_modules/vscode-langservers-extracted/bin"

lspconfig["cssls"].setup({
  capabilities = lsp_config.capabilities,
  on_attach = lsp_config.common_on_attach,
  cmd = { vs_lang_server_path .. "/vscode-css-language-server", "--stdio" },
})

lspconfig["html"].setup({
  capabilities = lsp_config.capabilities,
  on_attach = lsp_config.common_on_attach,
  cmd = { vs_lang_server_path .. "/vscode-html-language-server", "--stdio" },
})

lspconfig["tailwindcss"].setup({
  cmd = {
    lang_servers_path .. "/tailwind/node_modules/@tailwindcss/language-server/bin/tailwindcss-language-server",
    "--stdio",
  },
  filetypes = {
    "html",
    "markdown",
    "mdx",
    "css",
    "postcss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  root_dir = util.root_pattern("tailwind.config.js", "tailwind.config.ts"),
})

lspconfig["emmet_ls"].setup({
  capabilities = lsp_config.capabilities,
  on_attach = lsp_config.common_on_attach,
  cmd = { lang_servers_path .. "/emmet/node_modules/emmet-ls/out/server.js", "--stdio" },
  filetypes = { "html" },
  root_dir = util.root_pattern("package.json", ".git"),
})

lspconfig["pyright"].setup({
  capabilities = lsp_config.capabilities,
  on_attach = lsp_config.common_on_attach,
  cmd = { lang_servers_path .. "/python/node_modules/pyright/langserver.index.js", "--stdio" },
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

lspconfig["gopls"].setup({
  capabilities = lsp_config.capabilities,
  on_attach = lsp_config.common_on_attach,
})

local sumneko_root_path = lang_servers_path .. "/lua/lua-language-server"
local sumneko_binary_path = sumneko_root_path .. "/bin/Linux/lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig["sumneko_lua"].setup({
  capabilities = lsp_config.capabilities,
  on_attach = lsp_config.common_on_attach,
  cmd = { sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua" },
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

local rust_analyzer_path = lang_servers_path .. "/rust/rust-analyzer-x86_64-unknown-linux-gnu"

require("rust-tools").setup({
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  server = {
    capabilities = lsp_config.capabilities,
    on_attach = lsp_config.common_on_attach,
    cmd = { rust_analyzer_path },
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importGranularity = "module",
          importPrefix = "by_self",
        },
        cargo = {
          loadOutDirsFromCheck = true,
        },
        procMacro = {
          enable = true,
        },
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
})

null_ls.setup({
  sources = {
    -- js, ts, json
    null_ls.builtins.formatting.prettier.with({
      command = lang_servers_path .. "/typescript/node_modules/prettier/bin-prettier.js",
      args = { "--stdin-filepath", "$FILENAME" },
    }),
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
      extra_args = { "--config-path", lang_servers_path .. "/lua/stylua.toml" },
    }),
  },
})
