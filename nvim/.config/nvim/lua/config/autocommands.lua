local function augroup(name)
  return vim.api.nvim_create_augroup(
    "custom_autocommands_" .. name,
    { clear = true }
  )
end

-- vim.api.nvim_create_autocmd({ "LspAttach" }, {
-- group = augroup("lsp_attach"),
-- callback = function(args)
-- local bufnr = args.buf
-- local client = vim.lsp.get_client_by_id(args.data.client_id)
-- if client.server_capabilities.completionProvider then
-- vim.print("setting omni")
-- vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
-- end
-- if client.server_capabilities.definitionProvider then
-- vim.print("setting tagfunc")
-- vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
-- end
-- end
-- })

-- Wrap text on markdown and git commits
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("wrap_text"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 100 })
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "startuptime",
    "tsplayground",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
