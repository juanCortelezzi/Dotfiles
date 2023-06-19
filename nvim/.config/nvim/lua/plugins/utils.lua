return {
  "nvim-lua/plenary.nvim",
  "ThePrimeagen/harpoon",
  {
    "windwp/nvim-autopairs",
    opts = {
      check_ts = true,
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      enable_check_bracket_line = true,
    },
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
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
  {
    "m4xshen/hardtime.nvim",
    enabled = false,
    lazy = true,
    opts = {
      max_time = 1000,
      max_count = 5,
      disable_mouse = true,
      hint = true,
      allow_different_key = false,
      resetting_keys = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "c", "d", "x", "X", "p", "P" },
      restricted_keys = { "h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" },
      hint_keys = { "k", "j", "^", "$", "a", "i", "d", "y", "c", "l" },
      disabled_keys = { "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" },
      disabled_filetypes = { "qf", "netrw", "neo-tree", "lazy", "mason" },
    },
  },
}
