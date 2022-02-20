local M = {
  clientkeys = require("mappings.client").setup(),
  globalkeys = require("mappings.global").setup(),
  clientbuttons = require("mappings.clientbuttons").setup(),
}

M.globalkeys = require("mappings.binder").extend(M.globalkeys)

return M
