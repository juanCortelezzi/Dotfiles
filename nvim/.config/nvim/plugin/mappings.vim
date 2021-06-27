" map leader -> <SPACE>
nnoremap <SPACE> <Nop>
let mapleader=' '

" esc esc -> jj not proud of this, but i got used to it
inoremap jj <ESC><ESC>

" leader vi -> re source vimrc
noremap <Leader>vi <cmd>so ~/.config/nvim/init.vim<CR>

" Telescope
nnoremap <leader>t <cmd>Telescope<cr>
nnoremap <TAB> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>g <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>f <cmd>lua require('telescope.builtin').file_browser()<cr>

" Harpoon
nnoremap <leader>m <cmd>lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>M <cmd>lua require("harpoon.mark").rm_file()<CR>
nnoremap <leader>ch <cmd>lua require("harpoon.mark").clear_all()<CR>
nnoremap <leader>; <cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <leader>h <cmd>lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>j <cmd>lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <leader>k <cmd>lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <leader>l <cmd>lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <leader>u <cmd>lua require("harpoon.term").gotoTerminal(1)<CR>
tnoremap <silent> <leader>u <C-\><C-n>

" vimwiki
nnoremap <leader>wn <Plug>VimwikiNextLink<CR>

" LSP
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent> <leader>rn <cmd>lua require('lspsaga.rename').rename()<CR>
nnoremap <silent> <leader>a <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent> <leader>a <cmd><C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
nnoremap <silent> [g <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]g <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
nnoremap <silent> <A-t> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>
tnoremap <silent> <A-t> <cmd>lua require('lspsaga.floaterm').close_float_terminal()<CR>
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR> compe#confirm('<CR>')
inoremap <silent><expr> <C-e> compe#close('<C-e>')

" FUCK ARROW KEYS
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" idk what it is but it scares me
noremap Q <Nop>

" Arduino
" autocmd FileType ino nnoremap <buffer><leader>am :ArduinoVerify<CR>
" autocmd FileType ino nnoremap <buffer><leader>au :ArduinoUpload<CR>
" autocmd FileType ino nnoremap <buffer><leader>ad :ArduinoUploadAndSerial<CR>
" autocmd FileType ino nnoremap <buffer><leader>ab :ArduinoChooseBoard<CR>
" autocmd FileType ino nnoremap <buffer><leader>ap :ArduinoChooseProgrammer<CR>
