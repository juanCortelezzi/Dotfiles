local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function T(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local luasnip = require("luasnip")
require("luasnip/loaders/from_vscode").lazy_load()
local cmp = require("cmp")

-- load snippets
cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      local icons = require("wiz.lsp.kind").icons
      vim_item.kind = icons[vim_item.kind]
      vim_item.menu = ({
        nvim_lsp = "(LSP)",
        path = "(Path)",
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
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "buffer" },
    { name = "treesitter" },
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
        vim.api.nvim_feedkeys(T("<C-n>"), "n", true)
      elseif has_words_before() and luasnip.expand_or_jumpable() then
        vim.api.nvim_feedkeys(T("<Plug>luasnip-expand-or-jump"), "", true)
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
})
