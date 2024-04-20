---@type LazySpec
return {

  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = { "Neotree" },
  dependencies = {
    "plenary.nvim",
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    { "MunifTanjim/nui.nvim" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      enable_diagnostics = true,
      enable_git_status = false,
      sort_case_insensitive = true,
      use_default_mappings = false, -- maby change this
      window = {
        position = "right",
        width = 40,
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
            ["<C-v>"] = "open_vsplit",
          },
        },
      },
      file_size = {
        enabled = false,
        required_width = 64, -- min width of window required to show this column
      },
      type = {
        enabled = false,
        required_width = 122, -- min width of window required to show this column
      },
      last_modified = {
        enabled = false,
        required_width = 88, -- min width of window required to show this column
      },
      created = {
        enabled = false,
        required_width = 110, -- min width of window required to show this column
      },
      symlink_target = {
        enabled = false,
      },
    })
  end,
}
