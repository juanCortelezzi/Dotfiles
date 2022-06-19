-- Use 'q' to quit from common plugins
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
--   callback = function()
--     vim.cmd [[
--       nnoremap <silent> <buffer> q :close<CR>
--       set nobuflisted
--     ]]
--   end,
-- })

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "AlphaReady" },
  callback = function()
    -- set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
    vim.cmd([[
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]])
  end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  -- vim.opt_local.wrap = true
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- NvimTree stuff that I dont understand
vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 100 })
  end,
})

-- set markdown ft on .wiki
vim.cmd([[autocmd BufNewFile,BufRead *.wiki,*.mdx set ft=markdown]])
-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
--   callback = function()
--     vim.highlight.on_yank({ higroup = "Visual", timeout = 100 })
--   end,
-- })
