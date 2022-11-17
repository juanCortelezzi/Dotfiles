local M = {}

M.set = function(colorscheme)
  local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

  if not ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
  end
end

local pre_config = {
  tokyonight = function(tokyonight)
    tokyonight.setup({
      --- @usage 'night' | 'moon' | 'storm' | 'day'
      style = "night",
      styles = {
        --[[ comments = { italic = true }, ]]
        --[[ keywords = { italic = true }, ]]
        --[[ sidebars = "dark", ]]
        --[[ floats = "dark", ]]
      },
      sidebars = { "qf", "vista_kind", "terminal", "packer" },
    })
  end,
  poimandres = function(poimandres)
    poimandres.setup({
      bold_vert_split = false, -- use bold vertical separators
      dim_nc_background = false, -- dim 'non-current' window backgrounds
      disable_background = false, -- disable background
      disable_float_background = false, -- disable background for floats
      disable_italics = false, -- disable italics
    })
  end,
  catppuccin = function(catppuccin)
    catppuccin.setup({
      -- @usage 'mocha' | 'macchiato' | 'frappe' | 'latte'
      flavour = "macchiato",
    })
  end,
  ["rose-pine"] = function(rosepine)
    rosepine.setup({
      --- @usage 'main' | 'moon'
      dark_variant = "moon",
    })
  end,
}

vim.api.nvim_create_autocmd("ColorSchemePre", {
  callback = function(a)
    local custom_setter = pre_config[a.match]
    if custom_setter == nil then
      return
    end

    local ok, colorscheme = pcall(require, a.match)
    if not ok then
      vim.notify("could not require" .. a.match)
      return
    end

    custom_setter(colorscheme)
  end,
})

return M
