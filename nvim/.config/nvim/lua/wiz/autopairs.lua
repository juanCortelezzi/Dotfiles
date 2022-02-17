local npairs_ok, npairs = pcall(require, "nvim-autopairs")
if not npairs_ok then
  print("error when loading Nvim Autopairs")
  return
end

local Rule = require("nvim-autopairs.rule")

npairs.setup({
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0, -- Offset from pattern match
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
})

local ntsc_ok, ntsc = pcall(require, "nvim-treesitter.configs")
if not ntsc_ok then
  print("error when loading nvim treesitter configs in autopairs config")
  return
end

ntsc.setup({ autopairs = { enable = true } })

local ts_conds = require("nvim-autopairs.ts-conds")

-- press % => %% is only inside comment or string
npairs.add_rules({
  Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
  Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
})

-- add cmp <CR> mapping

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
  print("error when loading cmp in autopairs config")
  return
end

cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
