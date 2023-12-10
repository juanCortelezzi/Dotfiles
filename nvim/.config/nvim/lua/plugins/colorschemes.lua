---@type LazySpec[]
return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = { style = "moon" },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = { dark_variant = "moon" },
  },
  {
    "olivercederborg/poimandres.nvim",
    name = "poimandres",
    opts = {
      bold_vert_split = false, -- use bold vertical separators
      dim_nc_background = false, -- dim 'non-current' window backgrounds
      disable_background = false, -- disable background
      disable_float_background = false, -- disable background for floats
      disable_italics = false, -- disable italics
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = { flavour = "mocha" },
  },
}
