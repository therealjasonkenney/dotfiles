local M = {}

M.config = function()
  local util = require("util")

  local cmd = util.mason_path() .. "/ltex-ls-plus"

  return {
    name = "ltex",
    cmd = { cmd },
    filetypes = { "html", "markdown" },
    on_init = load_dictionary,
    settings = {
      ltex = {},
    },
  }
end

return M
