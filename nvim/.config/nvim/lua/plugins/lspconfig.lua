---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "mason.nvim",
    { "nvimtools/none-ls.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "folke/neodev.nvim", config = true },
    { "simrat39/rust-tools.nvim" },
  },
  config = function()
    -- Create an augroup that is used for managing our formatting autocmds.
    --      We need one augroup per client to make sure that multiple clients
    --      can attach to the same buffer without interfering with each other.
    local _augroups = {}
    local get_augroup = function(client)
      if not _augroups[client.id] then
        local group_name = "kickstart-lsp-format-" .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
      end

      return _augroups[client.id]
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup(
        "kickstart-lsp-attach-format",
        { clear = true }
      ),
      -- This is where we attach the autoformatting for reasonable clients
      callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        -- Only attach to clients that support document formatting
        if not client.server_capabilities.documentFormattingProvider then
          return
        end

        -- Tsserver usually works poorly. Sorry you work with bad languages
        -- You can remove this line if you know what you're doing :)
        if client.name == "tsserver" then
          return
        end

        -- Create an autocmd that will run *before* we save the buffer.
        --  Run the formatting command for the LSP that has just attached.
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = get_augroup(client),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              async = false,
              filter = function(c)
                return c.id == client.id
              end,
            })
          end,
        })
      end,
    })

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
      keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
      keymap("n", "gs", vim.lsp.buf.signature_help, opts)
      keymap("n", "<space>bf", function()
        vim.lsp.buf.format({ async = true })
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
              completion = {
                callSnippet = "Replace",
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

    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    null_ls.setup({
      debug = false,
      debounce = 150,
      on_attach = on_attach,
      sources = {
        -- js, ts, json
        formatting.prettier.with({
          extra_filetypes = { "toml", "astro", "svelte" },
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
        formatting.gofmt,
        -- formatting.gofumpt.with({
        --   extra_args = { "--extra" },
        --   env = {
        --     GOFUMPT_SPLIT_LONG_LINES = "on",
        --   },
        -- }),
        -- formatting.golines.with({
        --   extra_args = { "-m", 80, "-t", 2, "--base-formatter", "gofumpt" },
        --  -- command = 'golines %s -w --base-formatter="gofumpt"',
        -- }),

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
  end,
}
