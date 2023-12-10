---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-web-devicons" },
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = {
    options = {
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "NvimTree", "Trouble" },
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

      lualine_x = {},
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
}
