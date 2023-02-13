local M = {
  "nvim-lualine/lualine.nvim",
  -- enabled = true,
  event = "BufWinEnter",
}

M.opts = {
  options = {
    icons_enabled = true,
    theme = "auto",
    -- component_separators = { left = "", right = "" },
    -- section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "toggleterm", "startify", "alpha", "NvimTree", "neo-tree", "Trouble" },
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

    lualine_x = {
      {
        function()
          if not package.loaded["harpoon"] then
            return "ﯡ "
          end
          local harpoon_number = require("harpoon.mark").get_index_of(vim.fn.bufname())
          if harpoon_number then
            return "ﯠ " .. harpoon_number
          else
            return "ﯡ "
          end
        end,
        color = function()
          if not package.loaded["harpoon"] then
            return
          end
          if require("harpoon.mark").get_index_of(vim.fn.bufname()) then
            return { fg = "#98be65", gui = "bold" }
          end
        end,
      },
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {},
}

return M
