local M = {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local tokyonight = require("tokyonight")
      tokyonight.setup({
        --- @usage 'night' | 'moon' | 'storm' | 'day'
        style = "storm",
        styles = {
          --[[ comments = { italic = true }, ]]
          --[[ keywords = { italic = true }, ]]
          --[[ sidebars = "dark", ]]
          --[[ floats = "dark", ]]
        },
        sidebars = { "qf", "vista_kind", "terminal" },
      })
      tokyonight.load()
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      local rosepine = require("rose-pine")
      rosepine.setup({
        --- @usage 'main' | 'moon'
        dark_variant = "moon",
      })
    end,
  },
  {
    "olivercederborg/poimandres.nvim",
    config = function()
      local poimandres = require("poimandres")
      poimandres.setup({
        bold_vert_split = false, -- use bold vertical separators
        dim_nc_background = false, -- dim 'non-current' window backgrounds
        disable_background = false, -- disable background
        disable_float_background = false, -- disable background for floats
        disable_italics = false, -- disable italics
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      local catppuccin = require("catpuccin")
      catppuccin.setup({
        -- @usage 'mocha' | 'macchiato' | 'frappe' | 'latte'
        flavour = "macchiato",
      })
    end,
  },
}

return M
