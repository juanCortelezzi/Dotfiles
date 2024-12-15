---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  local lazyKey = keys.parse({ lhs, mode = mode })
  if keys.active[lazyKey.id] then
    vim.print("keymap '" .. lazyKey.id .. "' is already in use!!")
    return
  end

  opts = opts or {}
  opts.silent = opts.silent ~= false
  if opts.remap then
    opts.remap = nil
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map(
  "n",
  "<C-Left>",
  "<cmd>vertical resize -2<cr>",
  { desc = "Decrease window width" }
)
map(
  "n",
  "<C-Right>",
  "<cmd>vertical resize +2<cr>",
  { desc = "Increase window width" }
)

map(
  { "i", "n" },
  "<esc>",
  "<cmd>noh<cr><esc>",
  { desc = "Escape and clear hlsearch" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map(
  "n",
  "n",
  "'Nn'[v:searchforward]",
  { expr = true, desc = "Next search result" }
)
map(
  "x",
  "n",
  "'Nn'[v:searchforward]",
  { expr = true, desc = "Next search result" }
)
map(
  "o",
  "n",
  "'Nn'[v:searchforward]",
  { expr = true, desc = "Next search result" }
)
map(
  "n",
  "N",
  "'nN'[v:searchforward]",
  { expr = true, desc = "Prev search result" }
)
map(
  "x",
  "N",
  "'nN'[v:searchforward]",
  { expr = true, desc = "Prev search result" }
)
map(
  "o",
  "N",
  "'nN'[v:searchforward]",
  { expr = true, desc = "Prev search result" }
)

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<leader>x", ":source %<CR>")
