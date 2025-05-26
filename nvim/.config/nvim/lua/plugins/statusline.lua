---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons", optional = true },
  opts = {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "NvimTree", "Trouble" },
      always_divide_middle = false,
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", { "diagnostics" } },

      lualine_c = {
        { "%=" },
        { "filetype", icon_only = true },
        { "filename", path = 1 },
      },

      lualine_x = {},
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
}
