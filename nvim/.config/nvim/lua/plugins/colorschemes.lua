-- @usage "tokyonight" | "rosepine" | "poimandres" | "catppuccin"
local colorscheme = "catppuccin"
-- local configs = {
--   ["tokyonight-storm"] = { style = "storm", sidebars = { "qf", "vista_kind", "terminal" } },
--   ["tokyonight-night"] = { style = "night", sidebars = { "qf", "vista_kind", "terminal" } },
--   ["tokyonight-moon"] = { style = "moon", sidebars = { "qf", "vista_kind", "terminal" } },
--   ["rosepine"] = { dark_variant = "main" },
--   ["rosepine-moon"] = { dark_variant = "moon" },
--   ["poimandres"] = {
--     bold_vert_split = false, -- use bold vertical separators
--     dim_nc_background = false, -- dim 'non-current' window backgrounds
--     disable_background = false, -- disable background
--     disable_float_background = false, -- disable background for floats
--     disable_italics = false, -- disable italics
--   },
--   ["catpuccin-macchiato"] = { flavour = "macchiato" },
--   ["catpuccin-mocha"] = { flavour = "mocha" },
--   ["catpuccin-frappe"] = { flavour = "frappe" },
--   ["catpuccin-latte"] = { flavour = "latte" },
-- }

local M = {
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
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
    name = "rosepine",
    config = function()
      local rosepine = require("rosepine")
      rosepine.setup({
        --- @usage 'main' | 'moon'
        dark_variant = "moon",
      })
      vim.cmd([[colorscheme rosepine]])
    end,
  },
  {
    "olivercederborg/poimandres.nvim",
    name = "poimandres",
    config = function()
      local poimandres = require("poimandres")
      poimandres.setup({
        bold_vert_split = false, -- use bold vertical separators
        dim_nc_background = false, -- dim 'non-current' window backgrounds
        disable_background = false, -- disable background
        disable_float_background = false, -- disable background for floats
        disable_italics = false, -- disable italics
      })
      vim.cmd([[colorscheme poimandres]])
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      local catppuccin = require("catppuccin")
      catppuccin.setup({
        -- @usage 'mocha' | 'macchiato' | 'frappe' | 'latte'
        flavour = "mocha",
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}

for i, color in ipairs(M) do
  if color.name == colorscheme then
    M[i].lazy = false
    M[i].priority = 1000
    break
  end
end

return M
