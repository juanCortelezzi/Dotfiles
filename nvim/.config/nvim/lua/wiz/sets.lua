local cmd = vim.cmd
local opt = vim.opt

cmd("filetype plugin on")

opt.hidden = true
opt.termguicolors = true
opt.fileencoding = "utf8"

-- File management
opt.backup = false
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
opt.completeopt = { "menuone", "noselect" }

-- Text rendering
opt.wrap = false

-- Numbers
opt.number = true
opt.relativenumber = true

-- UI
opt.mouse = "a"
opt.cmdheight = 1
opt.signcolumn = "yes"
opt.showmode = false
opt.cursorline = true
opt.scrolloff = 4
opt.updatetime = 300
opt.splitright = true
