local luasnip = require("luasnip")
local cmp = require("cmp")

local has_words_before = function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  return not vim.api.nvim_get_current_line():sub(1, cursor[2]):match("^%s$")
end

-- load snippets
require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      local icons = require("wiz.lsp.kind").icons
      vim_item.kind = icons[vim_item.kind]
      vim_item.menu = ({
        nvim_lsp = "(LSP)",
        emoji = "(Emoji)",
        path = "(Path)",
        calc = "(Calc)",
        luasnip = "(Snippet)",
        buffer = "(Buffer)",
      })[entry.source.name]
      vim_item.dup = ({
        buffer = 1,
        path = 1,
        nvim_lsp = 0,
      })[entry.source.name] or 0
      return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n", true)
      elseif has_words_before() and luasnip.expand_or_jumpable() then
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
          "",
          true
        )
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, {
      "i",
      "s",
    }),

    ["<S-Tab>"] = cmp.mapping(function()
      if vim.fn.pumvisible() == 1 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n", true)
      elseif luasnip.jumpable(-1) then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "", true)
      end
    end, {
      "i",
      "s",
    }),
  },
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "nvim_lua" },
    { name = "buffer" },
    { name = "calc" },
    { name = "emoji" },
    { name = "treesitter" },
    { name = "crates" },
  },
})
