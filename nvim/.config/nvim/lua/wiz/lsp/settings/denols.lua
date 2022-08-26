local nvim_lsp = require("lspconfig")

return {
  settings = {
    root_dir = nvim_lsp.util.root_pattern("falopa.json"),
    --[[ root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"), ]]
  },
}
