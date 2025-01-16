local M = {}

---configures the builtin diagnostics
---we use a plugin to render the virtual text
---when our cursor is on the diagnostic position.
---@return vim.diagnostic.Opts
M.config = function()
  return {
    float = false,
    severity_sort = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    virtual_text = false,
  }
end

return M
