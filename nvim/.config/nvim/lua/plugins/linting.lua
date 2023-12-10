-- local function debounce(ms, fn)
--   local timer = vim.loop.new_timer()
--   return function(...)
--     local argv = { ... }
--     timer:start(ms, 0, function()
--       timer:stop()
--       vim.schedule_wrap(fn)(unpack(argv))
--     end)
--   end
-- end

---@type LazySpec
return {
  "mfussenegger/nvim-lint",
  enabled = false,
  event = "VeryLazy",
  config = function()
    require("lint").linters_by_ft = {
      linters_by_ft = {
        typescript = { "eslint" },
        lua = { "luacheck" },
        php = { "phpstan" },
        python = { "pylint" },
        bash = { "shellcheck" },
        zsh = { "zsh" },
      },
    }
    -- vim.api.nvim_create_autocmd(
    --   { "BufWritePost", "BufReadPost", "InsertLeave" },
    --   {
    --     group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
    --     callback = debounce(100, M.lint),
    --   }
    -- )
  end,
}
