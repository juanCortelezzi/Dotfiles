local null_ls = require("null-ls")

null_ls.config({ sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.gofmt,
}})

require("lspconfig")["null-ls"].setup({
    autostart = true,
})
