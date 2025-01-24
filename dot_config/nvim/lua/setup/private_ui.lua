local M = {}

--- Sets up global configuration related to neovim's UI
--- outside of plugin configuration.
--- * Confirm to save changes before exiting modified buffer
--- * Wrap lines at convenient points
--- * Show some invisible characters (tabs...
--- * Enable mouse mode
--- * Print line number
--- * Relative line numbers
M.setup = function()
  local opt = vim.opt

  opt.confirm = true
  opt.linebreak = true
  opt.list = true
  opt.mouse = "a"
  opt.number = true
  opt.relativenumber = true
end

return M
