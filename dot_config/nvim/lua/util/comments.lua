local M = {}

---Add a comment header to a file
---@param token string the token that designates a comment i.e. '#'
M.add_header = function(token)
  local bufnr = vim.api.nvim_get_current_buf()
  local strict = true
  local hdr = string.rep(string.sub(token, 1, 1), 75)
  local line_idx = 0
  local window = vim.api.nvim_get_current_win()

  local lines = {
    token .. " " .. hdr,
    token .. " ",
    token .. " " .. hdr,
  }

  vim.api.nvim_buf_set_lines(bufnr, line_idx, line_idx, strict, lines)

  vim.api.nvim_win_set_cursor(window, { 1, 2 })
end

return M
