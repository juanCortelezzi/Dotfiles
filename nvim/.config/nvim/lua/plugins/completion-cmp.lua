---@type LazySpec
return {
  "hrsh7th/nvim-cmp",
  version = false,
  event = "InsertEnter",
  enabled = false,
  dependencies = {
    { "nvim-autopairs", optional = true },
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    local auto_select = false

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noinsert"
          .. (auto_select and "" or ",noselect"),
      },
      preselect = auto_select and cmp.PreselectMode.Item
        or cmp.PreselectMode.None,

      sources = cmp.config.sources({
        { name = "lazydev", group_index = 0 },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, {
        { name = "buffer", keyword_length = 5, max_item_count = 3 },
      }),

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-n>"] = cmp.mapping.select_next_item({
          behavior = cmp.SelectBehavior.Insert,
        }),
        ["<C-p>"] = cmp.mapping.select_prev_item({
          behavior = cmp.SelectBehavior.Insert,
        }),
        ["<C-d>"] = cmp.mapping.scroll_docs(2),
        ["<C-u>"] = cmp.mapping.scroll_docs(-2),
        ["<C-j>"] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable() then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable() then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-y>"] = cmp.mapping(
          cmp.mapping.confirm({ select = true }),
          { "i", "c" }
        ),
        -- -- Accept currently selected item. If none selected, `select` first item.
        -- -- Set `select` to `false` to only confirm explicitly selected items.
        -- ["<CR>"] = cmp.mapping.confirm({
        --   select = false,
        --   behavior = cmp.ConfirmBehavior.Replace,
        -- }),
      }),
      formatting = {
        fields = { "kind", "abbr" },
        expandable_indicator = true,
        format = lspkind.cmp_format({
          mode = "symbol",
          maxwidth = {
            -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            -- can also be a function to dynamically calculate max width such as
            -- menu = function() return math.floor(0.45 * vim.o.columns) end,
            menu = 50, -- leading text (labelDetails)
            abbr = 50, -- actual suggestion item
          },
          ellipsis_char = "...",
          show_labelDetails = true, -- show labelDetails in menu. Disabled by default
          -- before = function(_, vim_item)
          --   vim_item.menu = ""
          --   return vim_item
          -- end,
        }),
      },
    })

    -- `/` cmdline setup.
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
      ---@diagnostic disable-next-line
      matching = { disallow_symbol_nonprefix_matching = false },
    })

    cmp.event:on("confirm_done", function()
      local ok, autopairs = pcall(require, "nvim-autopairs.completion.cmp")
      if not ok then
        return nil
      end
      return autopairs.on_confirm_done()
    end)
  end,
}
