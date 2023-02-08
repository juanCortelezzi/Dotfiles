return {
  "nvim-neo-tree/neo-tree.nvim",
  -- enabled = true,
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  init = function()
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  end,
  cmd = { "Neotree" },
  config = {
    close_if_last_window = true,
    enable_diagnostics = true,
    enable_git_status = false,
    git_status_async = false,
    sort_case_insensitive = true, -- used when sorting files and directories in the tree
    use_default_mappings = false, -- maby change this
    window = {
      position = "right",
      width = 30,
      mappings = {
        ["l"] = nil,
        ["h"] = "open",
        ["R"] = "refresh",
        ["r"] = "rename",
        ["d"] = "delete",
        ["a"] = {
          "add",
          -- some commands may take optional config options, see `:h neo-tree-mappings` for details
          config = {
            show_path = "absolute", -- "none", "relative", "absolute"
          },
        },
        ["x"] = "cut_to_clipboard",
        ["y"] = "copy_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["q"] = "close_window",
        ["<esc>"] = "close_window",
        ["?"] = "show_help",
      },
    },
    filesystem = {
      hijack_netrw_behavior = "disabled",
      window = {
        mappings = {
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["u"] = "navigate_up",
          ["."] = "set_root",
        },
      },
    },
  },
}
