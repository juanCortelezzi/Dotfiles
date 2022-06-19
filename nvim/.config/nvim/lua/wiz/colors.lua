local M = {}

M.set = function(colorscheme)
  local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

  if not ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
  end
end

local pre_config = {
  tokyonight = function()
    vim.g.tokyonight_style = "night"
    vim.g.tokyonight_italic_functions = true
    vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
  end,
  ["rose-pine"] = function()
    require("rose-pine").setup({
      --- @usage 'main' | 'moon'
      dark_variant = "moon",
    })
  end,
}

vim.api.nvim_create_autocmd({ "ColorSchemePre" }, {
  callback = function(a)
    -- print("cooooloooorsss", a.match)
    local custom_setter = pre_config[a.match]
    if custom_setter ~= nil then
      -- print("setting")
      custom_setter()
    end
  end,
})

return M
