local M = {}

M.config = function()
  local dap = require("dap")
  local dapui = require("dapui")
  local map = vim.keymap.set

  -- Setup UI
  dapui.setup({})

  dap.listeners.before.attach.dapui_config = function()
    dapui.open({})
  end

  dap.listeners.before.launch.dapui_config = function()
    dapui.open({})
  end

  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close({})
  end

  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close({})
  end

  map("n", "<leader>du", dapui.toggle, { desc = "[d]AP: Toggle UI" })
end

return M
