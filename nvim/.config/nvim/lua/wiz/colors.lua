local M = {}

local function set_colorscheme(colorscheme)
  local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

  if not is_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
  end
end

local custom_setters = {
  tokyonight = function()
    vim.g.tokyonight_style = "night"
    vim.g.tokyonight_italic_functions = true
    vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

    set_colorscheme("tokyonight")
  end,
  ["rose-pine"] = function()
    -- @usage 'main' | 'moon' | 'dawn'
    vim.g.rose_pine_variant = "moon"

    set_colorscheme("rose-pine")
  end,
}

function M.set(colorscheme)
  local custom_setter = custom_setters[colorscheme]

  if custom_setter ~= nil then
    custom_setter()
  else
    set_colorscheme(colorscheme)
  end
end

return M
