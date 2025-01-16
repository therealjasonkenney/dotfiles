local M = {}

M.adapter = {
  type = "executable",
  command = "elixir-ls-debugger",
  args = {},
}

M.config = {
  type = "mix_task",
  name = "mix test",
  task = "test",
  taskArgs = { "--trace" },
  request = "launch",
  startApps = true, -- for Phoenix projects
  projectDir = "${workspaceFolder}",
  requireFiles = {
    "test/**/test_helper.exs",
    "test/**/*_test.exs",
  },
}

return M
