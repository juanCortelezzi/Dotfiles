return {
  "nvim-lua/plenary.nvim",
  "ThePrimeagen/harpoon",
  {
    "windwp/nvim-autopairs",
    config = {
      check_ts = true,
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      enable_check_bracket_line = true,
    },
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = {
      auto_open = false,
      use_diagnostic_signs = true, -- en
    },
  },
  {
    -- TODO: check this
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
