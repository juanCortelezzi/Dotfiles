---@type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- "nvim-telescope/telescope-dap.nvim",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      {

        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },
    config = function()
      local dap = require("dap")
      local ui = require("dapui")

      ui.setup()
      require("mason-nvim-dap").setup({
        automatic_installation = false,
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
        },

        ensure_installed = {},
      })

      vim.keymap.set("n", "<space>db", dap.toggle_breakpoint)
      vim.keymap.set("n", "<space>dc", dap.continue)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
  },
}
