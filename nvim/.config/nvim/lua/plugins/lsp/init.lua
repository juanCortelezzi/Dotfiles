local M = {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "simrat39/rust-tools.nvim",
    "folke/neodev.nvim",
  },
}

function M.config()
  local lspconfig = require("lspconfig")
  local mason_lsp = require("mason-lspconfig")
  local handlers = require("plugins.lsp.config")
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
      local rust_config = require("plugins.lsp.settings.rust")
      local rust_tools = require("rust-tools")

      rust_tools.setup({
        server = {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = rust_config.opts,
        },
        tools = rust_config.tools,
      })
    end,

    ["lua_ls"] = function()
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = require("plugins.lsp.settings.lua"),
      })
    end,

    ["tsserver"] = function()
      lspconfig.tsserver.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("package.json"),
        filetypes = { "typescript", "typescriptreact", "typescript.tsx", "mdx", "javascript" },
        single_file_support = false,
      })
    end,

    ["pyright"] = function()
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = require("plugins.lsp.settings.pyright"),
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

    ["tailwindcss"] = function()
      lspconfig.tailwindcss.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx", "astro", "javascript" },
      })
    end,
  })

  require("plugins.null-ls").setup(on_attach)
end

function M.init()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  vim.diagnostic.config({
    virtual_text = true, -- disable virtual text
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

return M
