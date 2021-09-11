require("wiz.whichkey")
local map = vim.api.nvim_set_keymap
local noremap = { noremap = true }
local silentNoremap = { noremap = true, silent = true }

-- map leader -> <SPACE>
map("n", "<Space>", "", {})
vim.g.mapleader = " "

-- esc esc -> jj not proud of this, but i got used to it
map("i", "jj", "<ESC><ESC>", noremap)

map("n", "<TAB>", "<cmd>Telescope find_files<CR>", noremap)

-- Tab switch buffer
map("n", "<S-l>", ":BufferNext<CR>", silentNoremap)
map("n", "<S-h>", ":BufferPrevious<CR>", silentNoremap)

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", silentNoremap)
map("n", "<C-Down>", ":resize +2<CR>", silentNoremap)
map("n", "<C-Left>", ":vertical resize -2<CR>", silentNoremap)
map("n", "<C-Right>", ":vertical resize +2<CR>", silentNoremap)

-- Better indenting
map("v", "<", "<gv", silentNoremap)
map("v", ">", ">gv", silentNoremap)

-- LSP
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", silentNoremap)
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", silentNoremap)
map("n", "gR", "<cmd>TroubleToggle lsp_references<CR>", silentNoremap)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", silentNoremap)
map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", silentNoremap)
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", silentNoremap)

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

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {

  ["/"] = { "<cmd>CommentToggle<CR>", "Comment" },
  a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Codeaction" },
  c = { "<cmd>BufferClose<CR>", "Close Buffer" },

  -- Renaming action
  r = {
    n = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
  },

  -- Diagnostics
  d = {
    name = "Diagnostics",
    ["["] = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Prev" },
    ["]"] = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Next" },
    l = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", "Line" },
    d = { "<cmd>TroubleToggle lsp_document_diagnostics<CR>", "Document" },
    p = { "<cmd>TroubleToggle lsp_workspace_diagnostics<CR>", "Project" },
    n = { "<cmd>TodoTrouble<CR>", "Notes" },
  },

  -- Telescope
  f = { "<cmd>Telescope file_browser<CR>", "Find files" },
  g = { "<cmd>Telescope live_grep<CR>", "Project grep" },
  t = {
    name = "Telescope",
    t = { "<cmd>Telescope<CR>", "Builtin" },
    c = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
    f = { "<cmd>Telescope filetypes<CR>", "Filetypes" },
    z = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Fuzzy find" },
  },

  -- Harpoon
  h = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", "Harpoon 1" },
  j = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", "Harpoon 2" },
  k = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "Harpoon 3" },
  l = { "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", "Harpoon 4" },
  [";"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Harpoon menu" },
  m = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "Harpoon add" },
  M = { "<cmd>lua require('harpoon.mark').rm_file()<CR>", "Harpoon remove" },

  -- Buffer Actions
  b = {
    name = "Buffer",
    t = { "<cmd>Telescope buffers<CR>", "Telescope" },
    j = { "<cmd>BufferPick<CR>", "Jump" },
    w = { "<cmd>BufferWipeout<CR>", "Wipeout" },
    e = { "<cmd>BufferCloseAllButCurrent<cr>", "Close all but current" },
    h = { "<cmd>BufferCloseBuffersLeft<cr>", "Close all to the left" },
    l = { "<cmd>BufferCloseBuffersRight<cr>", "Close all to the right" },
    D = { "<cmd>BufferOrderByDirectory<cr>", "Sort by directory" },
    L = { "<cmd>BufferOrderByLanguage<cr>", "Sort by language" },

    -- Formatting
    f = { "<cmd>lua vim.lsp.buf.formatting_sync(nil, 1000)<CR>", "Formatting" },

    -- Colorizer
    c = {
      name = "Colorizer",
      a = { "<cmd>ColorizerAttachToBuffer<CR>", "Attach" },
      d = { "<cmd>ColorizerDetachFromBuffer<CR>", "Detach" },
      r = { "<cmd>ColorizerReloadAllBuffers<CR>", "Reload" },
    },
  },

  -- Packer
  p = {
    name = "Packer",
    C = { "<cmd>PackerClean<CR>", "Clean" },
    c = { "<cmd>PackerCompile<CR>", "Compile" },
    i = { "<cmd>PackerInstall<CR>", "Install" },
    r = { "<cmd>luafile %<CR>", "Reload" },
    S = { "<cmd>PackerSync<CR>", "Sync" },
    s = { "<cmd>PackerStatus<CR>", "Status" },
    u = { "<cmd>PackerUpdate<CR>", "Update" },
  },
}

-- : doesnt get you out of visual mode
-- <cmd> does
local vmappings = {
  ["/"] = { ":CommentToggle<CR>", "Comment" },
}

local wk = require("which-key")
wk.register(mappings, opts)
wk.register(vmappings, vopts)
