---@param ms number
---@param fn function
---@return function
local function debounce(ms, fn)
  local timer = vim.uv.new_timer()
  assert(timer ~= nil, "timer should be defined")
  return function(...)
    local argv = { ... }
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end

return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  enabled = false,
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      lua = { "luacheck" },
      rust = { "clippy" },
      bash = { "shellcheck" },
      php = { "phpstan" },
    }

    local shitty_fts = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      -- "astro",
      "svelte",
    }

    for _, ft in ipairs(shitty_fts) do
      lint.linters_by_ft[ft] = { "eslint_d" }
    end

    vim.api.nvim_create_autocmd(
      { "BufWritePost", "BufReadPost", "InsertLeave" },
      {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = debounce(100, function()
          lint.try_lint()
        end),
      }
    )
  end,
}
