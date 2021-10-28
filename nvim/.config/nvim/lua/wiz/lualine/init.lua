require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "nord",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "toggleterm", "startify", "alpha" },
    always_divide_middle = false,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", { "diagnostics", sources = { "nvim_lsp" } } },
    lualine_c = { "filename" },

    lualine_x = { "filetype" },
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
