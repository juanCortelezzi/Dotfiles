local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  print("could not load lspconfig")
  return
end

require("wiz.lsp.lsp-installer")
require("wiz.lsp.handlers").setup()
require("wiz.lsp.null-ls")
