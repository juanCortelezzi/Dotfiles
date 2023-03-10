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
      ["core.norg.concealer"] = {
        config = {
          folds = false,
          icon_preset = "diamond",
        },
      },
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            notes = "~/Documents/Stuff/Notas/Neorg",
          },
          default_workspace = "notes",
          autochdrir = true,
        },
      },
    },
  },
}
