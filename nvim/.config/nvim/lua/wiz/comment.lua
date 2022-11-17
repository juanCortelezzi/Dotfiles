local comment_ok, comment = pcall(require, "Comment")
if not comment_ok then
  return
end

local ts_context_ok, ts_context = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
if not ts_context_ok then
  return
end

comment.setup({
  pre_hook = ts_context.create_pre_hook(),
})
