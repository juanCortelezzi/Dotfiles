-- README:
-- if installing for the first time, comment impatient and require the plugins
-- first

local impatient_ok, _ = pcall(require, "impatient")
if not impatient_ok then
  print("error when loading impatient")
end

-- bundle whichkey mappings on config function plugin load
require("wiz.sets")
require("wiz.plugins")
require("wiz.mappings")

-- set colorscheme
-- require("wiz.colors").set("tokyonight")
-- require("wiz.colors").set("marambio")
require("wiz.colors").set("rose-pine")

-- set filetype on wiki files
vim.cmd([[autocmd BufNewFile,BufRead *.wiki,*.mdx set ft=markdown]])
