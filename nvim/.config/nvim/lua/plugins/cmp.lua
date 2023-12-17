---@type LazySpec
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "nvim-lspconfig",
    "nvim-autopairs",
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    {
      "L3MON4D3/LuaSnip",
      dependencies = {
        { "rafamadriz/friendly-snippets" },
        { "saadparwaiz1/cmp_luasnip" },
      },
      config = function()
        -- require("luasnip").config.setup({})
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local kind_icons = {
      Array = "",
      Boolean = "",
      Class = "",
      Color = "",
      Constant = "",
      Constructor = "",
      Enum = "",
      EnumMember = "",
      Event = "",
      Field = "",
      File = "",
      Folder = "󰉋",
      Function = "",
      Interface = "",
      Key = "",
      Keyword = "",
      Method = "",
      Module = "",
      Namespace = "",
      Null = "󰟢",
      Number = "",
      Object = "",
      Operator = "",
      Package = "",
      Property = "",
      Reference = "",
      Snippet = "",
      String = "",
      Struct = "",
      Text = "",
      TypeParameter = "",
      Unit = "",
      Value = "",
      Variable = "",
    }

    cmp.setup({
      preselect = cmp.PreselectMode.None,
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(2),
        ["<C-u>"] = cmp.mapping.scroll_docs(-2),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-f>"] = cmp.mapping(function()
          if luasnip.choice_active() then
            require("luasnip.extras.select_choice")()
          end
        end, { "i" }),
        ["<C-j>"] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable() then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable() then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i" }),
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({
          select = false,
          behavior = cmp.ConfirmBehavior.Replace,
        }),
      }),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            nvim_lua = "[Lua]",
            path = "[Path]",
            luasnip = "[Snip]",
            buffer = "[Buff]",
            emoji = "",
          })[entry.source.name]

          return vim_item
        end,
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, { name = "nvim_lua" }, {
        { name = "buffer", keyword_length = 5, max_item_count = 3 },
        { name = "path" },
      }),
    })

    -- `/` cmdline setup.
    cmp.setup.cmdline("/", {
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
    })
    cmp.event:on(
      "confirm_done",
      require("nvim-autopairs.completion.cmp").on_confirm_done()
    )
  end,
}
