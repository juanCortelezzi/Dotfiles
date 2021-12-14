require("impatient")
require("wiz.sets")

-- set colorscheme
vim.cmd([[colorscheme marambio]])

-- Tokyonight config
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- set filetype on wiki files
vim.cmd([[autocmd BufNewFile,BufRead *.wiki,*.mdx set ft=markdown]])

-- bundle whichkey mappings on config function plugin load
require("wiz.plugins")
require("wiz.mappings")
