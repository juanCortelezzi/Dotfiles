require("impatient")
require("wiz.sets")

-- set colorscheme
require("wiz.colors").set("tokyonight")

-- set filetype on wiki files
vim.cmd([[autocmd BufNewFile,BufRead *.wiki,*.mdx set ft=markdown]])

-- bundle whichkey mappings on config function plugin load
require("wiz.plugins")
require("wiz.mappings")
