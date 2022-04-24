local opt = vim.opt

opt.hidden = true
opt.termguicolors = true
opt.fileencoding = "utf8"

-- File management
opt.backup = false
opt.writebackup = false
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.backup = false
opt.undodir = "/home/wiz/.config/nvim/undodir"
opt.undofile = true

-- Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.shortmess:append("c")
opt.smartindent = true
opt.colorcolumn = "81"
opt.textwidth = 80

-- Search
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.completeopt = { "menuone", "noselect" }

-- Text rendering
opt.wrap = false

-- Numbers
opt.number = true
opt.relativenumber = true

-- UI
opt.guifont = "monospace:h17"
opt.mouse = "a"
opt.cmdheight = 1
opt.signcolumn = "yes"
opt.showmode = false
opt.cursorline = true
opt.scrolloff = 8
opt.updatetime = 300
opt.splitright = true
opt.laststatus = 3

vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_spec = 1
