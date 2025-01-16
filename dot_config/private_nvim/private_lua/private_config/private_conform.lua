local M = {}

M.config = function()
  local conform = require("conform")
  local map = vim.keymap.set

  map({ "n", "v" }, "gq", function()
    conform.format({ async = true })
  end, { desc = "Format document." })

  conform.setup({
    formatters_by_ft = {
      json = { "prettierd" },
      lua = { "stylua" },
      ruby = { "rubyfmt" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      timeout_ms = 500,
    },
  })
end

return M
