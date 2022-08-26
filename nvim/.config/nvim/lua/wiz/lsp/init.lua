-- required to be called in this order
local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  print("could not load mason")
  return
end

local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not mason_lsp_ok then
  print("could not load mason-lspconfig")
  return
end

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  print("could not load lspconfig")
  return
end

mason.setup()

local servers = {
  "cssls",
  "dockerls",
  "eslint",
  "gopls",
  "jsonls",
  "prismals",
  "pyright",
  "sumneko_lua",
  "rust_analyzer",
  "tailwindcss",
  "tsserver",
  "zls",
  "denols",
}

mason_lsp.setup({
  ensure_installed = servers,
})

local handlers = require("wiz.lsp.handlers")

handlers.setup()
local on_attach = handlers.on_attach
local capabilities = handlers.capabilities

mason_lsp.setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,

  -- Next, you can provide targeted overrides for specific servers.
  ["rust_analyzer"] = function()
    local rust_config = require("wiz.lsp.settings.rust")

    local rust_tools_ok, rust_tools = pcall(require, "rust-tools")
    if not rust_tools_ok then
      print("could not load rust-tools")
      return
    end

    rust_tools.setup({
      server = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = rust_config.opts,
      },
      tools = rust_config.tools,
    })
  end,

  ["sumneko_lua"] = function()
    lspconfig.sumneko_lua.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = require("wiz.lsp.settings.sumneko_lua"),
    })
  end,

  ["tsserver"] = function()
    lspconfig.tsserver.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern("package.json"),
    })
  end,

  ["pyright"] = function()
    lspconfig.pyright.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = require("wiz.lsp.settings.pyright"),
    })
  end,

  ["denols"] = function()
    lspconfig.denols.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern("deno.json", "deno.cjson"),
      filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    })
  end,
})

require("wiz.lsp.null-ls")
