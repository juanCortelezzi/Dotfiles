local ok, lualine = pcall(require, "lualine")
if not ok then
  print("error when loading lualine")
  return
end

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

    lualine_x = { { "filetype", icons_enabled = false } },
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
