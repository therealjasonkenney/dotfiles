local M = {}

M.adapter = {
  type = "server",
  host = "127.0.0.1",
  port = "${port}",
  executable = {
    command = vim.fn.exepath("codelldb"),
    args = { "--port", "${port}" },
  },
}

M.config = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/" .. "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

return M
