local M = {}

M.setup = function()
  local signs = {
    active = true,
    values = {
      { name = "DiagnosticSignError", text = "" },
      { name = "DiagnosticSignWarn", text = "" },
      { name = "DiagnosticSignHint", text = "" },
      { name = "DiagnosticSignInfo", text = "" },
    },
  }

  for _, sign in ipairs(signs.values) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  local config = {
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
end

M.capabilities = (function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return require("cmp_nvim_lsp").update_capabilities(capabilities)
end)()

M.on_attach = function(client)
  require("wiz.lsp.dochighlight").lsp_highlight_document(client)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
  vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 2000)]])
end

return M
