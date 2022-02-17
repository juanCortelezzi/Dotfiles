local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
  print("error when loading telescope")
  return
end

local icons_ok, icons = pcall(require, "nvim-web-devicons")
if not icons_ok then
  print("error when loading icons in telescope config")
  return
end

local actions = require("telescope.actions")
local previewers = require("telescope.previewers")

icons.setup({
  default = true,
})

local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job
    :new({
      command = "file",
      args = { "--mime-type", "-b", filepath },
      on_exit = function(j)
        local mime_type = vim.split(j:result()[1], "/")[1]
        if mime_type == "text" then
          previewers.buffer_previewer_maker(filepath, bufnr, opts)
        else
          -- maybe we want to write something to the buffer here
          vim.schedule(function()
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
          end)
        end
      end,
    })
    :sync()
end

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
    file_ignore_patterns = {
      "node_modules/.*",
      "target/.*",
      "dist/.*",
      ".next/.*",
      ".git/.*",
      "__pycache__",
    },
    buffer_previewer_maker = new_maker,
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
})
