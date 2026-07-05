local json_decoder = function(str)
  local json = require("plenary.json")
  return vim.json.decode(json.json_strip_comments(str))
end

local openui = function()
  require("dapui").open({})
end

local closeui = function()
  require("dapui").close({})
end

local augroup = vim.api.nvim_create_augroup("user.dap", { clear = true })

vim.api.nvim_create_autocmd("BufRead", {
  desc = "Setup Debugging",
  group = augroup,
  callback = function(args)
    local root_dir = vim.fs.root(args.buf, ".vscode")
    local launch_json = string.format("%s/%s", root_dir, ".vscode/launch.json")

    if vim.fn.filereadable(launch_json) == 0 then
      return
    end

    vim.pack.add({
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/nvim-neotest/nvim-nio",
      "https://github.com/rcarriga/nvim-dap-ui",
      "https://github.com/theHamsta/nvim-dap-virtual-text",
      "https://github.com/suketa/nvim-dap-ruby",
      "https://github.com/mfusseneggar/nvim-dap",
    })

    local dap = require("dap")
    local dapui = require("dapui")
    local map = vim.keymap.set
    local listeners = dap.listeners.before
    local vscode = require("dap.ext.vscode")

    -- Setup virtual text
    require("nvim-dap-virtual-text").setup()

    -- Setup UI
    dapui.setup()

    listeners.attach.dapui_config = openui
    listeners.launch.dapui_config = openui
    listeners.event_terminated.dapui_config = closeui
    listeners.event_exited.dapui_config = closeui

    -- Allow dap to use .vscode/launch.json
    vscode.json_decode = json_decoder

    -- Setup keymaps.
    map(
      "n",
      "<leader>db",
      dap.toggle_breakpoint,
      { buffer = args.buf, desc = "[d]AP: Toggle [b]reakpoint" }
    )

    map("n", "<leader>dB", function()
      local condition = vim.fn.input("Breakpoint condition: ")
      dap.set_breakpoint(condition)
    end, { buffer = args.buf, desc = "[d]AP: Set [b]reakpoint with condition." })

    map(
      "n",
      "<leader>dc",
      dap.continue,
      { buffer = args.buf, desc = "[d]AP: Run/[c]ontinue session." }
    )
    map("n", "<leader>dC", dap.run_to_cursor, { desc = "[d]AP: Run to [C]ursor" })
    map(
      "n",
      "<leader>dg",
      dap.goto_,
      { buffer = args.buf, desc = "[d]AP: [g]o to Line (No Execute)" }
    )
    map("n", "<leader>di", dap.step_into, { desc = "[d]AP: Step [i]nto" })
    map(
      "n",
      "<leader>dj",
      dap.down,
      { buffer = args.buf, desc = "[d]AP: Travel down the stacktrace" }
    )
    map(
      "n",
      "<leader>dk",
      dap.up,
      { buffer = args.buf, desc = "[d]AP: Travel up the stacktrace" }
    )
    map(
      "n",
      "<leader>do",
      dap.step_out,
      { buffer = args.buf, desc = "[d]AP: Step [o]ut" }
    )
    map(
      "n",
      "<leader>dO",
      dap.step_over,
      { buffer = args.buf, desc = "[d]AP: Step [O]ver" }
    )
    map(
      "n",
      "<leader>dP",
      dap.pause,
      { buffer = args.buf, desc = "[d]AP: Pause session." }
    )
    map(
      "n",
      "<leader>dr",
      dap.repl.toggle,
      { buffer = args.buf, desc = "[d]AP: Toggle [r]EPL." }
    )
    map(
      "n",
      "<leader>dt",
      dap.terminate,
      { desc = "[d]AP: [t]erminate session." }
    )

    map("n", "<leader>du", dapui.toggle, { desc = "[d]AP: Toggle UI" })
  end
})
