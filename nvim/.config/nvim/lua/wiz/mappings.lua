local map = vim.api.nvim_set_keymap

-- map leader -> <SPACE>
map("n", "<Space>", "", {})
vim.g.mapleader = " "

local options = {noremap = true}
local silentOptions = {noremap = true, silent = true}
local silentExprOptions = {noremap = true, silent = true, expr = true}
-- esc esc -> jj not proud of this, but i got used to it
map("i", "jj", "<ESC><ESC>", options)

-- leader vi -> re source vimrc
map("n", "<leader>vi", "<cmd>so ~/.config/nvim/init.vim<cr>", options)

-- Telescope
map("n", "<leader>t", "<cmd>Telescope<cr>", options)
map("n", "<TAB>", "<cmd>lua require('telescope.builtin').find_files()<cr>", options)
map("n", "<leader>g", "<cmd>lua require('telescope.builtin').live_grep()<cr>", options)
map("n", "<leader>f", "<cmd>lua require('telescope.builtin').file_browser()<cr>", options)

-- Harpoon
map("n", "<leader>m", "<cmd>lua require('harpoon.mark').add_file()<CR>", options)
map("n", "<leader>M", "<cmd>lua require('harpoon.mark').rm_file()<CR>", options)
map("n", "<leader>ch", "<cmd>lua require('harpoon.mark').clear_all()<CR>", options)
map("n", "<leader>;", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", options)
map("n", "<leader>h", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", options)
map("n", "<leader>j", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", options)
map("n", "<leader>k", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", options)
map("n", "<leader>l", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", options)
map("n", "<leader>u", "<cmd>lua require('harpoon.term').gotoTerminal(1)<CR>", options)
map("t", "<leader>u", "<C-\\><C-n>", silentOptions)

-- LSP
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", silentOptions)
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", silentOptions)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", silentOptions)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", silentOptions)
map("n", "gh", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", silentOptions)
map("n", "gs", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", silentOptions)
map("n", "K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", silentOptions)
map("n", "rn", "<cmd>lua require('lspsaga.rename').rename()<CR>", silentOptions)
map("n", "<leader>a", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", silentOptions)
map("v", "<leader>a", "<cmd><C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", silentOptions)
map("n", "[g", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", silentOptions)
map("n", "]g", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", silentOptions)
map("n", "<A-t>", "<cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>", silentOptions)
map("t", "<A-t>", "<cmd>lua require('lspsaga.floaterm').close_float_terminal()<CR>", silentOptions)
map("i", "<C-Space>", "compe#complete()", silentExprOptions)
map("i", "<CR>", "compe#confirm('<CR>')", silentExprOptions)
map("i", "<C-e>", "compe#close('<C-e>')", silentExprOptions)

-- " FUCK ARROW KEYS
-- noremap <Up> <Nop>
map("n", "<Up>", "<Nop>", options)
map("n", "<Down>", "<Nop>", options)
map("n", "<Left>", "<Nop>", options)
map("n", "<Right>", "<Nop>", options)
map("i", "<Up>", "<Nop>", options)
map("i", "<Down>", "<Nop>", options)
map("i", "<Left>", "<Nop>", options)
map("i", "<Right>", "<Nop>", options)
map("v", "<Up>", "<Nop>", options)
map("v", "<Down>", "<Nop>", options)
map("v", "<Left>", "<Nop>", options)
map("v", "<Right>", "<Nop>", options)

-- " idk what this is but it scares me
map("n", "Q", "<Nop>", options)

-- " Arduino
-- " autocmd FileType ino nnoremap <buffer><leader>am :ArduinoVerify<CR>
-- " autocmd FileType ino nnoremap <buffer><leader>au :ArduinoUpload<CR>
-- " autocmd FileType ino nnoremap <buffer><leader>ad :ArduinoUploadAndSerial<CR>
-- " autocmd FileType ino nnoremap <buffer><leader>ab :ArduinoChooseBoard<CR>
-- " autocmd FileType ino nnoremap <buffer><leader>ap :ArduinoChooseProgrammer<CR>
