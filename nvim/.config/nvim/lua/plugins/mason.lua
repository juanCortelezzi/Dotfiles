return {
  { "williamboman/mason.nvim", config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    config = {
      ensure_installed = {
        "gopls",
        "pyright",
        "sumneko_lua",
        "rust_analyzer",
        "tailwindcss",
        "tsserver",
        "denols",
      },
      ui = {
        check_outdated_packages_on_open = true,
      },
    },
  },
}