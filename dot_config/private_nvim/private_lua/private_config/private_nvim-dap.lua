local M = {}

M.config = function()
  local dap = require("dap")
  local json = require("plenary.json")
  local util = require("util")
  local vscode = require("dap.ext.vscode")
  local map = vim.keymap.set

  -- Setup virtual text
  require("nvim-dap-virtual-text").setup({})

  -- codelldb default configuration.
  dap.adapters.codelldb = {
    type = "executable",
    command = util.mason_path() .. "/codelldb",
  }

  -- Load project config via launch.json
  vscode.json_decode = function(str)
    return vim.json.decode(json.json_strip_comments(str))
  end

  -- Setup keymaps.
  map(
    "n",
    "<leader>db",
    dap.toggle_breakpoint,
    { desc = "[d]AP: Toggle [b]reakpoint" }
  )

  map("n", "<leader>dB", function()
    local condition = vim.fn.input("Breakpoint condition: ")
    dap.set_breakpoint(condition)
  end, { desc = "[d]AP: Set [b]reakpoint with condition." })

  map(
    "n",
    "<leader>dc",
    dap.continue,
    { desc = "[d]AP: Run/[c]ontinue session." }
  )
  map("n", "<leader>dC", dap.run_to_cursor, { desc = "[d]AP: Run to [C]ursor" })
  map(
    "n",
    "<leader>dg",
    dap.goto_,
    { desc = "[d]AP: [g]o to Line (No Execute)" }
  )
  map("n", "<leader>di", dap.step_into, { desc = "[d]AP: Step [i]nto" })
  map(
    "n",
    "<leader>dj",
    dap.down,
    { desc = "[d]AP: Travel down the stacktrace" }
  )
  map("n", "<leader>dk", dap.up, { desc = "[d]AP: Travel up the stacktrace" })
  map("n", "<leader>do", dap.step_out, { desc = "[d]AP: Step [o]ut" })
  map("n", "<leader>dO", dap.step_over, { desc = "[d]AP: Step [O]ver" })
  map("n", "<leader>dP", dap.pause, { desc = "[d]AP: Pause session." })
  map("n", "<leader>dr", dap.repl.toggle, { desc = "[d]AP: Toggle [r]EPL." })
  map(
    "n",
    "<leader>dt",
    dap.terminate,
    { desc = "[d]AP: [t]erminate session." }
  )
end

return M
