---@type "tokyonight" | "rose-pine"
local colorscheme = "rose-pine"

---@type LazyPluginSpec[]
local colorschemes = {
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    ---@module "tokyonight"
    ---@type tokyonight.Config
    opts = { style = "moon" },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    ---@module "rose-pine"
    ---@type Options
    opts = { variant = "moon" },
  },
}

return vim.tbl_map(
  ---@param c LazyPluginSpec
  ---@return LazyPluginSpec
  function(c)
    if c.name ~= colorscheme then
      return vim.tbl_extend("force", c, { event = "VeryLazy" })
    end

    ---@type LazyPluginSpec
    local new_opts = {
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function(plug, opts)
        require(plug.name).setup(opts)
        vim.cmd("colorscheme " .. colorscheme)
      end,
    }

    return vim.tbl_extend("force", c, new_opts)
  end,
  colorschemes
)
