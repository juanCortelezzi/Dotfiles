local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
  print("error when loading treesitter configs")
  return
end

treesitter.setup({
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
    "python",
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
