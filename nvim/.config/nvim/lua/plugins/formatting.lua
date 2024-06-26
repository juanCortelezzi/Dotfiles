---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = "ConformInfo",
  dependencies = { "mason.nvim" },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  config = function(_, opts)
    local conform = require("conform")

    local shitty_fts = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "json",
      "toml",
      "astro",
      "svelte",
      "yaml",
    }

    for _, ft in ipairs(shitty_fts) do
      conform.formatters_by_ft[ft] = { "prettier", "biome" }
    end

    conform.setup(opts)
  end,
  ---@class ConformOpts
  opts = {
    format = {
      timeout = 3000,
      -- not recommended to change
      async = false,
      quiet = false,
    },
    ---@type table<string, conform.FormatterUnit[]>
    formatters_by_ft = {
      python = { "black" },
      lua = { "stylua" },
      go = { "gofmt" },
      templ = { "gofmt" },
      rust = { "rustfmt" },
      bash = { "shfmt" },
      zig = { "zigfmt" },
      ocaml = { "ocamlformat" },
      php = { "pint" },
    },

    -- The options you set here will be merged with the builtin formatters.
    -- You can also define any custom formatters here.
    ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
    formatters = {
      injected = { options = { ignore_errors = true } },
      stylua = {
        prepend_args = {
          "--config-path",
          vim.fn.stdpath("config") .. "/stylua.toml",
        },
      },
      black = {
        extra_args = { "--fast" },
      },
      rustfmt = {
        extra_args = { "--edition", 2023 },
      },
    },
    --- will pass the table to conform.format({opts})
    format_on_save = {
      -- I recommend these options. See :help conform.format for details.
      lsp_fallback = true,
      timeout_ms = 500,
    },
  },
}
