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
map("n", "<leader>/", ":CommentToggle<CR>", silentNoremap)
map("v", "<leader>/", ":CommentToggle<CR>", silentNoremap)

-- Telescope
map("n", "<leader>t", "<cmd>Telescope<cr>", noremap)
map("n", "<TAB>", "<cmd>lua require('telescope.builtin').find_files()<cr>", noremap)
map("n", "<leader>g", "<cmd>lua require('telescope.builtin').live_grep()<cr>", noremap)
map("n", "<leader>f", "<cmd>lua require('telescope.builtin').file_browser()<cr>", noremap)

-- Harpoon
map("n", "<leader>m", "<cmd>lua require('harpoon.mark').add_file()<CR>", noremap)
map("n", "<leader>M", "<cmd>lua require('harpoon.mark').rm_file()<CR>", noremap)
map("n", "<leader>ch", "<cmd>lua require('harpoon.mark').clear_all()<CR>", noremap)
map("n", "<leader>;", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", noremap)
map("n", "<leader>h", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", noremap)
map("n", "<leader>j", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", noremap)
map("n", "<leader>k", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", noremap)
map("n", "<leader>l", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", noremap)
map("n", "<leader>u", "<cmd>lua require('harpoon.term').gotoTerminal(1)<CR>", noremap)
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

-- " FUCK ARROW KEYS
-- noremap <Up> <Nop>
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

-- " Arduino
-- " autocmd FileType ino nnoremap <buffer><leader>am :ArduinoVerify<CR>
-- " autocmd FileType ino nnoremap <buffer><leader>au :ArduinoUpload<CR>
-- " autocmd FileType ino nnoremap <buffer><leader>ad :ArduinoUploadAndSerial<CR>
-- " autocmd FileType ino nnoremap <buffer><leader>ab :ArduinoChooseBoard<CR>
-- " autocmd FileType ino nnoremap <buffer><leader>ap :ArduinoChooseProgrammer<CR>
