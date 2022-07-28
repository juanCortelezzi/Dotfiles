local ok, lualine = pcall(require, "lualine")
if not ok then
  print("error when loading lualine")
  return
end

local harpoon = {
  component = function()
    local harpoon_number = require("harpoon.mark").get_index_of(vim.fn.bufname())
    if harpoon_number then
      return "ﯠ " .. harpoon_number
    else
      return "ﯡ "
    end
  end,
  color = function()
    if require("harpoon.mark").get_index_of(vim.fn.bufname()) then
      return { fg = "#98be65", gui = "bold" }
    end
  end,
}

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    -- component_separators = { left = "", right = "" },
    -- section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "toggleterm", "startify", "alpha", "NvimTree", "Trouble" },
    always_divide_middle = false,
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      { "diagnostics", sources = { "nvim_diagnostic" } },
    },
    lualine_c = {
      { "%=" },
      { "filetype", icon_only = true },
      { "filename", path = 1 },
    },

    lualine_x = { { harpoon.component, color = harpoon.color } },
    lualine_y = { "progress" },
    lualine_z = { "location" },
    -- lualine_x = {},
    -- lualine_y = {},
    -- lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
