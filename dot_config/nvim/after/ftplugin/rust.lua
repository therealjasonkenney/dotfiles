local util = require("util")

vim.bo.shiftwidth = 4

local vscode_dir = vim.fs.root(0, { ".vscode" })

if vscode_dir and vim.fn.filereadable(vscode_dir .. "/.vscode/launch.json") then
  util.ensure_installed("codelldb")
  local dap = require("dap")

  -- codelldb default configuration.
  dap.adapters.codelldb = {
    type = "executable",
    command = util.mason_path() .. "/codelldb",
  }
end
