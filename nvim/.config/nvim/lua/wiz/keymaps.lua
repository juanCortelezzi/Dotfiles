local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t",
-- command_mode = "c",

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)

-- Clear highlights
-- keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- esc esc -> jj not proud of this, but i got used to it
keymap("i", "jj", "<ESC>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Diagnostics
keymap("n", "<leader>dd", "<cmd>TroubleToggle document_diagnostics<CR>", opts)
keymap("n", "<leader>dp", "<cmd>TroubleToggle workspace_diagnostics<CR>", opts)
keymap("n", "<leader>dn", "<cmd>TodoTelescope<CR>", opts)

-- NvimTree
keymap("n", "<leader><leader>", "<cmd>NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>f", "<cmd>Telescope find_files hidden=true no_ignore=true<CR>", opts)
keymap("n", "<leader>g", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>tt", "<cmd>Telescope<CR>", opts)
keymap("n", "<leader>tc", "<cmd>Telescope colorscheme<CR>", opts)
keymap("n", "<leader>tf", "<cmd>Telescope file_browser<CR>", opts)
keymap("n", "<leader>tz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", opts)
keymap("n", "<leader>tg", "<cmd>lua require('wiz.toggleterm.custom').lazygit_toggle()<CR>", opts)
keymap("n", "<leader>tl", "<cmd>lua require('wiz.toggleterm.custom').lf_toggle()<CR>", opts)

-- Harpoon
keymap("n", "<C-H>", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<C-J>", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<C-K>", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", opts)
keymap("n", "<C-L>", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", opts)
keymap("n", "<leader>;", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
keymap("n", "<leader>m", "<cmd>lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<leader>M", "<cmd>lua require('harpoon.mark').rm_file()<CR>", opts)

-- Buffer Actions
keymap("n", "<leader>bs", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>bd", "<cmd>bdelete<CR>", opts)

-- Colorizer
keymap("n", "<leader>bca", "<cmd>ColorizerAttachToBuffer<CR>", opts)
keymap("n", "<leader>bcd", "<cmd>ColorizerDetachFromBuffer<CR>", opts)
keymap("n", "<leader>bcr", "<cmd>ColorizerReloadAllBuffers<CR>", opts)

--Stuff
keymap("n", "<leader>s", "<cmd>Twilight<CR>", opts)

-- Packer
keymap("n", "<leader>pi", "<cmd>PackerInstall<CR>", opts)
keymap("n", "<leader>pc", "<cmd>PackerCompile<CR>", opts)
keymap("n", "<leader>pC", "<cmd>PackerClean<CR>", opts)
keymap("n", "<leader>pr", "<cmd>luafile %<CR>", opts)
keymap("n", "<leader>pS", "<cmd>PackerSync<CR>", opts)
keymap("n", "<leader>ps", "<cmd>PackerStatus<CR>", opts)
keymap("n", "<leader>pu", "<cmd>PackerUpdate<CR>", opts)

-- DAP
-- keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
-- keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
-- keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
-- keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
-- keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
-- keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
-- keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
-- keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
-- keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- FUCK ARROW KEYS
keymap("n", "<Up>", "<Nop>")
keymap("n", "<Down>", "<Nop>")
keymap("n", "<Left>", "<Nop>")
keymap("n", "<Right>", "<Nop>")
keymap("i", "<Up>", "<Nop>")
keymap("i", "<Down>", "<Nop>")
keymap("i", "<Left>", "<Nop>")
keymap("i", "<Right>", "<Nop>")
keymap("v", "<Up>", "<Nop>")
keymap("v", "<Down>", "<Nop>")
keymap("v", "<Left>", "<Nop>")
keymap("v", "<Right>", "<Nop>")

-- idk what the fuck this is but it scares me.
keymap("n", "Q", "<Nop>")
