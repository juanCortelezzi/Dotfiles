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
-- vim.g.loaded_gzip         = 1
-- vim.g.loaded_tar          = 1
-- vim.g.loaded_tarPlugin    = 1
-- vim.g.loaded_zipPlugin    = 1
-- vim.g.loaded_2html_plugin = 1
-- vim.g.loaded_netrw        = 1
-- vim.g.loaded_netrwPlugin  = 1
-- vim.g.loaded_matchit      = 1
-- vim.g.loaded_matchparen   = 1
-- vim.g.loaded_spec         = 1
