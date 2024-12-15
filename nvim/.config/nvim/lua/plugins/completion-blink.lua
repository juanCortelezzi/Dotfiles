---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    version = "*",
    enabled = true,
    opts_extend = {
      "sources.default",
      "sources.compat",
    },
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "saghen/blink.compat",
        optional = true, -- make optional so it's only enabled if any extras need it
        opts = {},
        version = "*",
      },
    },
    opts = {
      keymap = { preset = "default" },
      appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = true,
        -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      -- experimental signature help support
      signature = { enabled = true },
    },
    config = function(_, opts)
      -- setup compat sources
      local enabled = opts.sources.default
      for _, source in ipairs(opts.sources.compat or {}) do
        opts.sources.providers[source] = vim.tbl_deep_extend(
          "force",
          { name = source, module = "blink.compat.source" },
          opts.sources.providers[source] or {}
        )
        if
          type(enabled) == "table" and not vim.tbl_contains(enabled, source)
        then
          table.insert(enabled, source)
        end
      end

      -- check if we need to override symbol kinds
      for _, provider in pairs(opts.sources.providers or {}) do
        if provider.kind then
          require("blink.cmp.types").CompletionItemKind[provider.kind] =
            provider.kind
          local transform_items = provider.transform_items
          provider.transform_items = function(ctx, items)
            items = transform_items and transform_items(ctx, items) or items
            for _, item in ipairs(items) do
              item.kind = provider.kind or item.kind
            end
            return items
          end
        end
      end

      require("blink.cmp").setup(opts)
    end,
  },

  -- lazydev
  {
    "saghen/blink.cmp",
    dependencies = { "folke/lazydev.nvim" },
    opts = {
      sources = {
        default = { "lazydev" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- dont show LuaLS require statements when lazydev has items
            fallbacks = { "lsp" },
          },
        },
      },
    },
  },
}
