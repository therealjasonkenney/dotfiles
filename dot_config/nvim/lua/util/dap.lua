local M = {}

local openui = function()
  require("dapui").open({})
end

local closeui = function()
  require("dapui").close({})
end

---comment
---@param bufnr number
M.enable_dap = function(bufnr)
  local dap = require("dap")
  local dapui = require("dapui")
  local map = vim.keymap.set
  local listeners = dap.listeners.before

  -- Setup virtual text
  require("nvim-dap-virtual-text").setup({})

  -- Setup UI
  dapui.setup({})

  listeners.attach.dapui_config = openui
  listeners.launch.dapui_config = openui
  listeners.event_terminated.dapui_config = closeui
  listeners.event_exited.dapui_config = closeui

  -- Setup keymaps.
  map(
    "n",
    "<leader>db",
    dap.toggle_breakpoint,
    { buffer = bufnr, desc = "[d]AP: Toggle [b]reakpoint" }
  )

  map("n", "<leader>dB", function()
    local condition = vim.fn.input("Breakpoint condition: ")
    dap.set_breakpoint(condition)
  end, { buffer = bufnr, desc = "[d]AP: Set [b]reakpoint with condition." })

  map(
    "n",
    "<leader>dc",
    dap.continue,
    { buffer = bufnr, desc = "[d]AP: Run/[c]ontinue session." }
  )
  map("n", "<leader>dC", dap.run_to_cursor, { desc = "[d]AP: Run to [C]ursor" })
  map(
    "n",
    "<leader>dg",
    dap.goto_,
    { buffer = bufnr, desc = "[d]AP: [g]o to Line (No Execute)" }
  )
  map("n", "<leader>di", dap.step_into, { desc = "[d]AP: Step [i]nto" })
  map(
    "n",
    "<leader>dj",
    dap.down,
    { buffer = bufnr, desc = "[d]AP: Travel down the stacktrace" }
  )
  map(
    "n",
    "<leader>dk",
    dap.up,
    { buffer = bufnr, desc = "[d]AP: Travel up the stacktrace" }
  )
  map(
    "n",
    "<leader>do",
    dap.step_out,
    { buffer = bufnr, desc = "[d]AP: Step [o]ut" }
  )
  map(
    "n",
    "<leader>dO",
    dap.step_over,
    { buffer = bufnr, desc = "[d]AP: Step [O]ver" }
  )
  map(
    "n",
    "<leader>dP",
    dap.pause,
    { buffer = bufnr, desc = "[d]AP: Pause session." }
  )
  map(
    "n",
    "<leader>dr",
    dap.repl.toggle,
    { buffer = bufnr, desc = "[d]AP: Toggle [r]EPL." }
  )
  map(
    "n",
    "<leader>dt",
    dap.terminate,
    { desc = "[d]AP: [t]erminate session." }
  )

  map("n", "<leader>du", dapui.toggle, { desc = "[d]AP: Toggle UI" })
end

return M
