return {
  "phaazon/mind.nvim",
  enabled = false,
  opts = {
    persistence = {
      data_dir = "~/Documents/Stuff/Notas/Mind",
    },
    ui = {
      width = 30,
    },
    tree = {
      automatic_data_creation = false,
    },
    edit = {
      data_extension = ".norg",
      data_header = "* %s",
      -- copy_link_format = "[](%s)"
    },
    keymaps = {
      normal = {
        ["<cr>"] = "open_data",
        ["h"] = "toggle_node",
        -- ["<s-cr>"] = "open_data_index",
        -- ["<s-tab>"] = "toggle_node",
        -- ["/"] = "select_path",
        ["$"] = "change_icon_menu",
        c = "add_inside_end_index",
        I = "add_inside_start",
        i = "add_inside_end",
        y = "copy_node_link",
        Y = "copy_node_link_index",
        d = "delete",
        D = "delete_file",
        O = "add_above",
        o = "add_below",
        q = "quit",
        r = "rename",
        R = "change_icon",
        u = "make_url",
        x = "select",
      },
      selection = {
        ["<cr>"] = "open_data",
        ["<s-tab>"] = "toggle_node",
        -- ["/"] = "select_path",
        I = "move_inside_start",
        i = "move_inside_end",
        O = "move_above",
        o = "move_below",
        q = "quit",
        x = "select",
      },
    },
  },
}
