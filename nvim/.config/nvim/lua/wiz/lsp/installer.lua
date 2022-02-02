local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("wiz.lsp.handlers").on_attach,
    capabilities = require("wiz.lsp.handlers").capabilities,
  }

  if server.name == "sumneko_lua" then
    local sumneko_opts = require("wiz.lsp.settings.sumneko")
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  elseif server.name == "pyright" then
    local sumneko_opts = require("wiz.lsp.settings.sumneko")
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  elseif server.name == "rust_analyzer" then
    local rust_opts = require("wiz.lsp.settings.rust")
    opts = vim.tbl_deep_extend("force", rust_opts, opts)

    require("rust-tools").setup({
      tools = {
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
          show_parameter_hints = false,
          parameter_hints_prefix = "",
          other_hints_prefix = "",
        },
      },

      -- The "server" property provided in rust-tools setup function are the
      -- settings rust-tools will provide to lspconfig during init.
      -- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
      -- with the user's own settings (opts).
      server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
    })

    server:attach_buffers()
    return
  end

  server:setup(opts)
end)
