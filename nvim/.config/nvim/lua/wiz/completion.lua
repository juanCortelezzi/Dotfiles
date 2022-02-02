local cmp = require("cmp")
local luasnip = require("luasnip")

-- load snippets
cmp.setup({
  -- do not mess up snippets (?)
  preselect = false,
  formatting = {
    format = function(entry, vim_item)
      local icons = require("wiz.lsp.kind").icons
      vim_item.kind = icons[vim_item.kind]
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        path = "[Path]",
        luasnip = "[Snip]",
        buffer = "[Buff]",
      })[entry.source.name]
      return vim_item
    end,
  },
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer", keyword_lenght = 5 },
    { name = "treesitter" },
  },
  experimental = { ghost_text = false },
})

-- Use buffer source for `/`.
cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline", keyword_lenght = 5 },
  }),
})
