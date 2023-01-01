return {
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTelescope" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
  },

  {
    "numToStr/Comment.nvim",
    -- event = "VeryLazy",
    event = "BufReadPost",
    config = function()
      local comment = require("Comment")
      comment.setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },
}
