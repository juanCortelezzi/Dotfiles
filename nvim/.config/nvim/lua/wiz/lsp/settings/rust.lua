local opts = {
  standalone = false,
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "by_self",
      },
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}

local tools = {
  autoSetHints = true,
  hover_with_actions = true,
  inlay_hints = {
    show_parameter_hints = false,
    parameter_hints_prefix = "",
    other_hints_prefix = "",
  },
}

return {
  opts = opts,
  tools = tools,
}