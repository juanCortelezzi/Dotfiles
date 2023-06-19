local M = {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "simrat39/rust-tools.nvim",
    "folke/neodev.nvim",
    {
      "jose-elias-alvarez/null-ls.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      --   has_formatter = function(ft)
      --     local sources = require("null-ls.sources")
      --     local available = sources.get_available(ft, "NULL_LS_FORMATTING")
      --     return #available > 0
      --   end,
    },
  },
}

function M.config()
  local lspconfig = require("lspconfig")
  local mason_lsp = require("mason-lspconfig")
  local handlers = require("plugins.lsp.config")
  local null_ls = require("null-ls")
  local on_attach = handlers.on_attach
  local capabilities = handlers.capabilities
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  local formatting = null_ls.builtins.formatting

  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  -- local diagnostics = null_ls.builtins.diagnostics

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
        filetypes = {
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          "astro",
          "javascript",
        },
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "tv\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              },
            },
          },
        },
      })
    end,
  })

  null_ls.setup({
    debug = false,
    debounce = 150,
    on_attach = on_attach,
    sources = {
      -- js, ts, json
      formatting.prettier.with({
        extra_filetypes = { "toml", "astro" },
      }),
      -- python
      formatting.black.with({ extra_args = { "--fast" } }),
      -- diagnostics.flake8,
      -- lua
      formatting.stylua.with({
        extra_args = {
          "--config-path",
          vim.fn.stdpath("config") .. "/stylua.toml",
        },
      }),
      -- golang
      -- formatting.gofmt,
      -- formatting.gofumpt.with({
      --   extra_args = { "--extra" },
      --   env = {
      --     GOFUMPT_SPLIT_LONG_LINES = "on",
      --   },
      -- }),
      formatting.golines.with({
        extra_args = { "-m", 80, "-t", 2, "--base-formatter", "gofumpt" },
        -- command = 'golines %s -w --base-formatter="gofumpt"',
      }),

      -- rust
      formatting.rustfmt.with({
        extra_args = { "--edition", 2021 },
      }),
      -- bash
      null_ls.builtins.diagnostics.shellcheck,
      formatting.beautysh.with({
        extra_args = { "--indent-size", 2 },
      }),
      -- zig
      formatting.zigfmt,
      -- yaml
      formatting.yamlfmt,
      formatting.ocamlformat,
    },
  })
end

function M.init()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
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
