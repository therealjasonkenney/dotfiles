local function config()
  local dap = require("dap")
  local dapui = require("dapui")
  local keybinds = require("keybinds")

  local codelldb = require("plugins.debuggers.codelldb")
  local rdbg = require("plugins.debuggers.rbdg")

  dapui.setup()

  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end

  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end

  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end

  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end

  dap.adapters.codelldb = codelldb.adapter
  dap.adapters.ruby = rdbg.adapter
  dap.configurations.ruby = rdbg.config
  dap.configurations.rust = codelldb.config

  keybinds.set_debugger_continue("n", dap.continue, {})
  keybinds.set_debugger_toggle_breakpoint("n", dap.toggle_breakpoint, {})
end

return {
  "mfussenegger/nvim-dap",
  config = config,
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
    },
  },
}
