---@alias KeyboardType "dvorak" | "qwerty"

---@type KeyboardType
local keyboard = "qwerty"

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

---@param key string
---@param cmd string|function
local function nmap(key, cmd)
  keymap("n", key, cmd, opts)
end

-- normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t",
-- command_mode = "c",

-- Resize windows with arrows
nmap("<C-Up>", ":resize -2<CR>")
nmap("<C-Down>", ":resize +2<CR>")
nmap("<C-Left>", ":vertical resize -2<CR>")
nmap("<C-Right>", ":vertical resize +2<CR>")

nmap("<C-u>", "<C-u>zz")
nmap("<C-d>", "<C-d>zz")

-- esc esc -> jj not proud of this, but i got used to it
keymap("i", "jj", "<ESC>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Diagnostics
nmap("<leader>dd", "<cmd>TroubleToggle document_diagnostics<CR>")
nmap("<leader>dp", "<cmd>TroubleToggle workspace_diagnostics<CR>")
nmap("<leader>dn", "<cmd>TodoTelescope<CR>")
nmap("<leader>d[", vim.diagnostic.goto_prev)
nmap("<leader>d]", vim.diagnostic.goto_next)
nmap("<leader>dl", vim.diagnostic.open_float)

-- NvimTree
nmap("<leader><leader>", "<cmd>Neotree toggle reveal<CR>")

-- Telescope
nmap("<leader>f", "<cmd>Telescope find_files<CR>")
nmap("<leader>g", "<cmd>Telescope live_grep<CR>")
nmap("<leader>tt", "<cmd>Telescope<CR>")
nmap("<leader>tc", "<cmd>Telescope colorscheme<CR>")
nmap("<leader>tf", "<cmd>Telescope file_browser<CR>")
nmap("<leader>tz", "<cmd>Telescope current_buffer_fuzzy_find<CR>")

-- Harpoon

--- @param fn fun(h: Harpoon): nil
--- @return function
local function harpoon_wrapper(fn)
  return function()
    local ok, harpoon = pcall(require, "harpoon")
    if not ok then
      vim.notify("harpoon is not loaded yet!", vim.log.levels.WARN)
    end

    fn(harpoon)
  end
end

---@type Map<KeyboardType, Array<string>>
local harpoon_buffer_keymap = {
  qwerty = { "<C-H>", "<C-J>", "<C-K>", "<C-L>" },
  dvorak = { "<C-H>", "<C-T>", "<C-N>", "<C-S>" },
}

nmap(
  harpoon_buffer_keymap[keyboard][1],
  harpoon_wrapper(function(h)
    h:list():select(1)
  end)
)
nmap(
  harpoon_buffer_keymap[keyboard][2],
  harpoon_wrapper(function(h)
    h:list():select(2)
  end)
)
nmap(
  harpoon_buffer_keymap[keyboard][3],
  harpoon_wrapper(function(h)
    h:list():select(3)
  end)
)
nmap(
  harpoon_buffer_keymap[keyboard][4],
  harpoon_wrapper(function(h)
    h:list():select(4)
  end)
)

nmap(
  "<leader>m",
  harpoon_wrapper(function(h)
    h:list():append()
  end)
)
nmap(
  "<leader>;",
  harpoon_wrapper(function(h)
    h.ui:toggle_quick_menu(h:list())
  end)
)

-- Buffer Actions
nmap("<leader>bs", "<cmd>Telescope buffers<CR>")
nmap("<leader>bd", "<cmd>bdelete<CR>")

-- Colorizer
nmap("<leader>bca", "<cmd>ColorizerAttachToBuffer<CR>")
nmap("<leader>bcd", "<cmd>ColorizerDetachFromBuffer<CR>")
nmap("<leader>bcr", "<cmd>ColorizerReloadAllBuffers<CR>")
