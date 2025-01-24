local bufnr = vim.api.nvim_get_current_buf()
local elixir = require("elixir")
local elixirls = require("elixir.elixirls")
local util = require("util")

vim.keymap.set("v", "gm", ":ElixirExpandMacro<cr>", { buffer = bufnr })

elixir.setup({
  nextls = { enable = true },
  elixirls = {
    enable = true,
    settings = elixirls.settings({
      dialyzerEnabled = false,
      enableTestLenses = false,
    }),
  },
  projectionist = {
    enable = true,
  },
})

local dap = require("dap")

dap.adapters.mix_task = {
  type = "executable",
  command = "elixir-ls-debugger",
  args = {},
}

dap.configurations.elixir = {
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

util.enable_dap()
