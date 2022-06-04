local twilight_ok, twilight = pcall(require, "twilight")
if not twilight_ok then
  print("error when loading twilight")
  return
end

twilight.setup({
  dimming = {
    alpha = 0.25, -- amount of dimming
    -- we try to get the foreground from the highlight groups or fallback color
    color = { "Normal", "#ffffff" },
    inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
  },
  context = 5, -- amount of lines we will try to show around the current line
  treesitter = true, -- use treesitter when available for the filetype
  -- treesitter is used to automatically expand the visible text,
  -- but you can further control the types of nodes that should always be fully expanded
  expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
    "if_statement",
    -- "method_declaration",
    -- "function_declaration",
    -- "method",
    -- "function",
    -- "table",
  },
  exclude = {}, -- exclude these filetypes
})
