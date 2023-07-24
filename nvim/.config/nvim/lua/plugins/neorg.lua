return {
  "nvim-neorg/neorg",
  ft = { "norg" },
  cmd = { "Neorg" },
  build = ":Neorg sync-parsers",
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      ["core.concealer"] = {
        config = {
          folds = false,
          icon_preset = "diamond",
        },
      },
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "~/Documents/notas/neorg",
          },
          default_workspace = "notes",
          autochdrir = true,
        },
      },
    },
  },
}
