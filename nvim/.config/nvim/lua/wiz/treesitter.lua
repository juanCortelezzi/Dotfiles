require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "toml",
    "go",
    "gomod",
    "json",
    "lua",
    "rust",
  },
  highlight = {
    enable = true,
    disable = { "markdown" },
    additional_vim_regex_highlighting = true,
  },
  autopairs = { enable = false },

  indent = { enable = false, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
