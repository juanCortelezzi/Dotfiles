require("wiz")

vim.g.colors_name = "tokyonight"

-- Tokyonight
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- set filetype on wiki files
vim.cmd([[autocmd BufNewFile,BufRead *.wiki set ft=markdown]])
