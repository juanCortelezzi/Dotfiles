local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

npairs.setup({
  check_ts = true,
  ts_config = {
    lua = { "string" }, -- it will not add pair on that treesitter node
    javascript = { "template_string" },
  },
})

require("nvim-treesitter.configs").setup({ autopairs = { enable = true } })

local ts_conds = require("nvim-autopairs.ts-conds")

-- press % => %% is only inside comment or string
npairs.add_rules({
  Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
  Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
})

-- add cmp <CR> mapping
require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
