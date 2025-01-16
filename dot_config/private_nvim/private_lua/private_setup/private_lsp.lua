local M = {}

---Sets up default logging and root markers for lsp.
M.setup = function()
  vim.lsp.set_log_level(
    vim.lsp.protocol.MessageType.Warning
  )
end

return M
