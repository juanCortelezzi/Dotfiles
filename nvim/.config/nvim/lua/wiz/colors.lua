local M = {}

local colorshemes_config = {
  tokyonight = function()
    vim.g.tokyonight_style = "night"
    vim.g.tokyonight_italic_functions = true
    vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
  end,
}

function M.set(colorscheme)
  local config_function = colorshemes_config[colorscheme]

  if config_function ~= nil then
    config_function()
  end

  local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

  if not is_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
  end
end

return M
