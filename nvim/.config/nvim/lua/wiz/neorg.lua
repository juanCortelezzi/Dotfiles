local ok, neorg = pcall(require, "neorg")
if not ok then
  print("error when loading packer")
  return
end

neorg.setup({
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
    -- ["core.keybinds"] = {
    --   config = {
    --     default_keybinds = false,
    --     hook = function(keybinds)
    --       keybinds.remap_event("norg", "n", "<CR>", "core.norg.esupports.hop.hop-link")
    --       keybinds.remap_event("norg", "n", "<BS>", "core.norg.esupports.hop.hop-link")
    --     end,
    --   },
    -- },
  },
})
