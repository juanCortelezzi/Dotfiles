---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "mason.nvim",
    { "williamboman/mason-lspconfig.nvim" },
    { "folke/neodev.nvim", opts = {} },

    { "simrat39/rust-tools.nvim" },
  },
  config = function()
    local lsp_diagnostic_config = {
      signs = {
        active = true,
        -- values = {
        --   { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        --   { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
        --   { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
        --   { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
        -- },
      },
      virtual_text = true,
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
    }

    vim.diagnostic.config(lsp_diagnostic_config)
    vim.lsp.handlers["textDocument/hover"] =
      vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        max_width = 80,
      })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = "rounded", max_width = 80 }
    )
    require("lspconfig.ui.windows").default_options.border = "rounded"

    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = require("cmp_nvim_lsp").default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )

    local function on_attach(_, bufnr)
      local opts = { buffer = bufnr }
      local keymap = vim.keymap.set
      keymap("n", "gD", vim.lsp.buf.declaration, opts)
      keymap("n", "gd", vim.lsp.buf.definition, opts)
      keymap("n", "K", vim.lsp.buf.hover, opts)
      keymap("n", "gI", vim.lsp.buf.implementation, opts)
      keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
      keymap({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
      keymap("n", "<leader>d[", vim.diagnostic.goto_prev, opts)
      keymap("n", "<leader>d]", vim.diagnostic.goto_next, opts)
      keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
      keymap("n", "gs", vim.lsp.buf.signature_help, opts)
      keymap("n", "<space>bf", function()
        local ok, conform = pcall(require, "conform")
        if not ok then
          vim.notify("Conform is not loaded", vim.log.levels.WARN)
          vim.lsp.buf.format({ async = true })
        end
        conform.format()
      end, opts)
    end

    local lspconfig = require("lspconfig")
    mason_lspconfig.setup_handlers({
      function(server_name) -- default handler (optional)
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,

      ["rust_analyzer"] = function()
        local rust_tools = require("rust-tools")

        rust_tools.setup({
          server = {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
              ["rust-analyzer"] = {
                checkOnSave = {
                  command = "clippy",
                },
              },
            },
          },
          tools = {
            autoSetHints = true,
            inlay_hints = {
              show_parameter_hints = false,
              parameter_hints_prefix = "",
              other_hints_prefix = "",
            },
          },
        })
      end,

      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { "missing-fields" } },
              completion = { callSnippet = "Replace" },
            },
          },
        })
      end,

      ["intelephense"] = function()
        lspconfig.intelephense.setup({
          -- cmd = { "intelephense", "--stdio" },
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            intelephense = {
              format = {
                enable = true,
              },
            },
          },
        })
      end,

      ["tsserver"] = function()
        lspconfig.tsserver.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          root_dir = lspconfig.util.root_pattern("package.json"),
          filetypes = {
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "mdx",
            "javascript",
          },
          single_file_support = false,
        })
      end,

      ["pyright"] = function()
        lspconfig.pyright.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
              },
            },
          },
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
            "svelte",
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
  end,
}
