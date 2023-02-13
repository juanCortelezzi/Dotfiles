return {
  "nvim-neorg/neorg",
  ft = { "norg" },
  cmd = { "Neorg" },
  build = ":Neorg sync-parsers",
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.norg.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      -- ["core.norg.concealer"] = {},
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            notes = "~/Documents/Stuff/Notas/Neorg",
          },

          default_workspace = "notes",
          autochdir = true, -- Automatically change the directory to the current workspace's root every time
          index = "index.norg", -- The name of the main (root) .norg file
        },
      },
    },
  },
}
