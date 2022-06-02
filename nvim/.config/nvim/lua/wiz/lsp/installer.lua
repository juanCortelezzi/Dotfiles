local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  print("error when loading nvim lsp installer")
  return
end

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("wiz.lsp.handlers").on_attach,
    capabilities = require("wiz.lsp.handlers").capabilities,
  }

  if server.name == "sumneko_lua" then
    -- LUA
    local sumneko_opts = require("wiz.lsp.settings.sumneko")
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  elseif server.name == "pyright" then
    -- PYTHON
    local pyright_opts = require("wiz.lsp.settings.pyright")
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  elseif server.name == "rust_analyzer" then
    -- RUST
    local rust = require("wiz.lsp.settings.rust")
    opts = vim.tbl_deep_extend("force", rust.opts, opts)

    require("rust-tools").setup({
      server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
      tools = rust.tools,
    })

    server:attach_buffers()
    return
  end

  server:setup(opts)
end)
