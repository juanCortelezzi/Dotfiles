require("wiz.whichkey")
local map = vim.api.nvim_set_keymap

-- map leader -> <SPACE>
map("n", "<Space>", "", {})
vim.g.mapleader = " "

local noremap = {noremap = true}
local silentNoremap = {noremap = true, silent = true}
local silentExprNoremap = {noremap = true, silent = true, expr = true}

-- esc esc -> jj not proud of this, but i got used to it
map("i", "jj", "<ESC><ESC>", noremap)

-- leader vi -> re source vimrc
map("n", "<leader>vi", "<cmd>so ~/.config/nvim/init.vim<cr>", noremap)

-- Comments
map("n", "<leader>/", "<cmd>CommentToggle<CR>", silentNoremap)
map("v", "<leader>/", "<cmd>CommentToggle<CR>", silentNoremap)

-- Telescope
-- map("n", "<leader>t", "<cmd>Telescope<CR>", noremap)
-- map("n", "<leader>g", "<cmd>Telescope live_grep<CR>", noremap)
-- map("n", "<leader>f", "<cmd>Telescope file_browser<CR>", noremap)
map("n", "<TAB>", "<cmd>Telescope find_files<CR>", noremap)

-- Harpoon
-- map("n", "<leader>m", "<cmd>lua require('harpoon.mark').add_file()<CR>", noremap)
-- map("n", "<leader>M", "<cmd>lua require('harpoon.mark').rm_file()<CR>", noremap)
-- map("n", "<leader>ch", "<cmd>lua require('harpoon.mark').clear_all()<CR>", noremap)
-- map("n", "<leader>;", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", noremap)
-- map("n", "<leader>h", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", noremap)
-- map("n", "<leader>j", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", noremap)
-- map("n", "<leader>k", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", noremap)
-- map("n", "<leader>l", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", noremap)
-- map("n", "<leader>u", "<cmd>lua require('harpoon.term').gotoTerminal(1)<CR>", noremap)
map("t", "<leader>u", "<C-\\><C-n>", silentNoremap)

-- LSP
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", silentNoremap)
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", silentNoremap)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", silentNoremap)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", silentNoremap)
map("n", "gh", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", silentNoremap)
map("n", "gs", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", silentNoremap)
map("n", "K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", silentNoremap)
map("n", "rn", "<cmd>lua require('lspsaga.rename').rename()<CR>", silentNoremap)
map("n", "<leader>a", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", silentNoremap)
map("v", "<leader>a", "<cmd><C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", silentNoremap)
map("n", "[g", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", silentNoremap)
map("n", "]g", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", silentNoremap)
map("n", "<A-t>", "<cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>", silentNoremap)
map("t", "<A-t>", "<cmd>lua require('lspsaga.floaterm').close_float_terminal()<CR>", silentNoremap)
map("i", "<C-Space>", "compe#complete()", silentExprNoremap)
map("i", "<CR>", "compe#confirm('<CR>')", silentExprNoremap)
map("i", "<C-e>", "compe#close('<C-e>')", silentExprNoremap)

-- FUCK ARROW KEYS
map("n", "<Up>", "<Nop>", noremap)
map("n", "<Down>", "<Nop>", noremap)
map("n", "<Left>", "<Nop>", noremap)
map("n", "<Right>", "<Nop>", noremap)
map("i", "<Up>", "<Nop>", noremap)
map("i", "<Down>", "<Nop>", noremap)
map("i", "<Left>", "<Nop>", noremap)
map("i", "<Right>", "<Nop>", noremap)
map("v", "<Up>", "<Nop>", noremap)
map("v", "<Down>", "<Nop>", noremap)
map("v", "<Left>", "<Nop>", noremap)
map("v", "<Right>", "<Nop>", noremap)

-- " idk what this is but it scares me
map("n", "Q", "<Nop>", noremap)

local mappings = {

  ["/"] = "Comment",
  a = "Codeaction",

  -- Packer
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<CR>", "Compile" },
    i = { "<cmd>PackerInstall<CR>", "Install" },
    r = { ":luafile %<CR>", "Reload" },
    s = { "<cmd>PackerSync<CR>", "Sync" },
    u = { "<cmd>PackerUpdate<CR>", "Update" },
  },

  -- Telescope
  f = {"<cmd>Telescope find_files<CR>", "Find files"},
  g = {"<cmd>Telescope live_grep<CR>", "Project grep"},
  t = {
    name = "Telescope",
    t = {"<cmd>Telescope<CR>", "Builtin"},
    c = {"<cmd>Telescope colorscheme<CR>", "Colorscheme"},
    f = {"<cmd>Telescope filetypes<CR>", "Filetypes"},
    b = {"<cmd>Telescope buffers<CR>", "Buffers"},
    z = {"<cmd>Telescope current_buffer_fuzzy_find<CR>", "Fuzzy find"},
  },

  -- Colorizer
  c = {
    name = "Colorizer",
    a = {"<cmd>ColorizerAttachToBuffer<CR>", "Attatch"},
    d = {"<cmd>ColorizerDetachFromBuffer<CR>", "Detach"},
    r = {"<cmd>ColorizerReloadAllBuffers<CR>", "Reload"},
  },

  -- Harpoon
  h = {"<cmd>lua require('harpoon.ui').nav_file(1)<CR>", "Harpoon 1"},
  j = {"<cmd>lua require('harpoon.ui').nav_file(2)<CR>", "Harpoon 2"},
  k = {"<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "Harpoon 3"},
  l = {"<cmd>lua require('harpoon.ui').nav_file(4)<CR>", "Harpoon 4"},
  u = {"<cmd>lua require('harpoon.term').gotoTerminal(1)<CR>", "Harpoon terminal"},
  [";"] = {"<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Harpoon menu"},
  m = {"<cmd>lua require('harpoon.mark').add_file()<CR>", "Harpoon add"},
  M = {"<cmd>lua require('harpoon.mark').rm_file()<CR>", "Harpoon remove"},
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local wk = require "which-key"
wk.register(mappings, opts)
