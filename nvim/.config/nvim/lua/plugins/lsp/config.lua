local M = {}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
  keymap(bufnr, "n", "<leader>bf", "<cmd>lua vim.lsp.buf.format({async=true})<cr>", opts)
  keymap(bufnr, "n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  keymap(bufnr, "n", "<leader>d[", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
  keymap(bufnr, "n", "<leader>d]", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
  keymap(bufnr, "n", "<leader>dl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- only use null-ls for formatting
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

M.on_attach = function(client, bufnr)
  local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if not status_cmp_ok then
    print("could not load cmp")
    return
  end

  M.capabilities.textDocument.completion.completionItem.snippetSupport = true
  M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end

  lsp_keymaps(bufnr)
end

return M
