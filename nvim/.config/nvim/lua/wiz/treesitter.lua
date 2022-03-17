local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
  print("error when loading treesitter configs")
  return
end

treesitter.setup({
  ensure_installed = {
    "typescript",
    "tsx",
    "javascript",
    "json",
    "html",
    "css",
    "python",
    "bash",
    "go",
    "gomod",
    "lua",
    "rust",
    "toml",
    "yaml",
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
