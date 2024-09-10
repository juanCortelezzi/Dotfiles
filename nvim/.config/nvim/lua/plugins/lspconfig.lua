---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "simrat39/rust-tools.nvim",
    { "folke/neodev.nvim", opts = {} },
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    -- probably should set this up:
    -- https://github.com/b0o/SchemaStore.nvim
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

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = "rounded", max_width = 80 }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = "rounded", max_width = 80 }
    )

    require("lspconfig.ui.windows").default_options.border = "rounded"

    -- set filetype for templ
    vim.filetype.add({ extension = { templ = "templ" } })

    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local cmp = require("cmp_nvim_lsp")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities =
      vim.tbl_deep_extend("force", capabilities, cmp.default_capabilities())

    local function on_attach(client, bufnr)
      local opts = { buffer = bufnr }
      local keymap = vim.keymap.set
      keymap("n", "gD", vim.lsp.buf.declaration, opts)
      keymap("n", "gd", vim.lsp.buf.definition, opts)
      keymap("n", "K", vim.lsp.buf.hover, opts)
      keymap("n", "gI", vim.lsp.buf.implementation, opts)
      keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
      keymap({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
      keymap("n", "<leader>d[", function()
        vim.diagnostic.jump({ count = -1 })
      end, opts)
      keymap("n", "<leader>d]", function()
        vim.diagnostic.jump({ count = 1 })
      end, opts)
      keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
      keymap("n", "gs", vim.lsp.buf.signature_help, opts)
      keymap("n", "<leader>bf", function()
        local ok, conform = pcall(require, "conform")
        if not ok then
          vim.notify("Conform is not loaded", vim.log.levels.WARN)
          vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
          return
        end
        conform.format({ bufnr = bufnr, lsp_fallback = true, timeout_ms = 2000 })
      end, opts)

      local filetype = vim.bo[bufnr].filetype
      if filetype == "lua" then
        client.server_capabilities.semanticTokensProvider = nil
      end

      if
        client
        and client.server_capabilities.inlayHintProvider
        and vim.lsp.inlay_hint
      then
        keymap("n", "<leader>i", function()
          vim.lsp.inlay_hint.enable(
            not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
          )
        end)
      end
    end

    local lspconfig = require("lspconfig")

    -- Mason LSP Servers

    mason_lspconfig.setup_handlers({
      function(server_name) -- default handler (optional)
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,

      ["lexical"] = function()
        local path = vim.fn.expand("~/.local/share/nvim/mason/bin/lexical")
        lspconfig["lexical"].setup({
          cmd = { path, "server" },
          root_dir = lspconfig.util.root_pattern({ "mix.exs" }),
          on_attach = on_attach,
          capabilities = vim.tbl_deep_extend("force", capabilities, {
            textDocument = {
              hover = nil,
            },
          }),
        })
      end,

      ["elixirls"] = function()
        lspconfig["lexical"].setup({
          on_attach = on_attach,
          capabilities = {
            textDocument = {
              hover = {
                dynamicRegistration = true,
                contentFormat = { "markdown", "plaintext" },
              },
            },
          },
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
