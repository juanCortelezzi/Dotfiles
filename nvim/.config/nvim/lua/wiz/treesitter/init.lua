require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
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
  },
  autopairs = { enable = false },
})
