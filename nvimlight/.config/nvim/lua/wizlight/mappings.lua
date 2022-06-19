local map = vim.api.nvim_set_keymap
local noremap = { noremap = true }

-- map leader -> <SPACE>
map("n", "<Space>", "", {})
vim.g.mapleader = " "

-- esc esc -> jj not proud of this, but i got used to it
map("i", "jj", "<ESC><ESC>", noremap)

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

-- idk what the fuck is this but it scares me.
map("n", "Q", "<Nop>", noremap)

map("n", "<C-Up>", ":resize -2<CR>", noremap)
map("n", "<C-Down>", ":resize +2<CR>", noremap)
map("n", "<C-Left>", ":vertical resize +2<CR>", noremap)
map("n", "<C-Right>", ":vertical resize -2<CR>", noremap)
map("v", "<", "<gv", noremap)
map("v", ">", ">gv", noremap)
