local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

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

-- esc esc -> jj not proud of this, but i got used to it
keymap("i", "jj", "<ESC>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Diagnostics
keymap("n", "<leader>dd", "<cmd>TroubleToggle document_diagnostics<CR>", opts)
keymap("n", "<leader>dp", "<cmd>TroubleToggle workspace_diagnostics<CR>", opts)
keymap("n", "<leader>dn", "<cmd>TodoTelescope<CR>", opts)
keymap("n", "<leader>d[", vim.diagnostic.goto_prev, opts)
keymap("n", "<leader>d]", vim.diagnostic.goto_next, opts)
keymap("n", "<leader>dl", vim.diagnostic.open_float, opts)

-- NvimTree
keymap("n", "<leader><leader>", "<cmd>Neotree toggle<CR>", opts)

-- Telescope
keymap("n", "<leader>f", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>g", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>tt", "<cmd>Telescope<CR>", opts)
keymap("n", "<leader>tc", "<cmd>Telescope colorscheme<CR>", opts)
keymap("n", "<leader>tf", "<cmd>Telescope file_browser<CR>", opts)
keymap("n", "<leader>tz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", opts)

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
-- keymap("n", "<leader>s", "<cmd>Twilight<CR>", opts)

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
