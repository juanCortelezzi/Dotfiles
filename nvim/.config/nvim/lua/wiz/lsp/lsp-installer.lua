local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  print("could not load nvim-lsp-installer")
  return
end

local servers = {
  "cssls",
  "dockerls",
  "eslint",
  "gopls",
  "jsonls",
  "prismals",
  "pyright",
  "sumneko_lua",
  "tailwindcss",
  "tsserver",
}

lsp_installer.setup({
  ensure_installed = servers,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  print("could not load lspconfig")
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("wiz.lsp.handlers").on_attach,
    capabilities = require("wiz.lsp.handlers").capabilities,
  }

  if server == "sumneko_lua" then
    local sumneko_opts = require("wiz.lsp.settings.sumneko_lua")
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require("wiz.lsp.settings.pyright")
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "rust_analyzer" then
    local rust_config = require("wiz.lsp.settings.rust")

    require("rust-tools").setup({
      server = vim.tbl_deep_extend("force", rust_config.opts, opts),
      tools = rust_config.tools,
    })
    return
  end

  lspconfig[server].setup(opts)
end