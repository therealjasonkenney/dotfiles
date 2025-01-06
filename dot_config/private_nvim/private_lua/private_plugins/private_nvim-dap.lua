local function config(_, opts)
	local dap = require("dap")
	local dapui = require("dapui")
	local json = require("plenary.json")
	local vscode = require("dap.ext.vscode")
	local map = vim.keymap.set

	map("n", "<leader>db", dap.toggle_breakpoint, { desc = "[d]AP: Toggle [b]reakpoint" })

	map("n", "<leader>dB", function()
		local condition = vim.fn.input("Breakpoint condition: ")
		dap.set_breakpoint(condition)
	end, { desc = "[d]AP: Set [b]reakpoint with condition." })

	map("n", "<leader>dc", dap.continue, { desc = "[d]AP: Run/[c]ontinue session." })
	map("n", "<leader>dC", dap.run_to_cursor, { desc = "[d]AP: Run to [C]ursor" })
	map("n", "<leader>de", dap.eval, { desc = "[d]AP: Evaluate Expression" })
	map("v", "<leader>de", dap.eval, { desc = "[d]AP: Evaluate Expression" })
	map("n", "<leader>dg", dap.goto_, { desc = "[d]AP: [g]o to Line (No Execute)" })
	map("n", "<leader>di", dap.step_into, { desc = "[d]AP: Step [i]nto" })
	map("n", "<leader>dj", dap.down, { desc = "[d]AP: Travel down the stacktrace" })
	map("n", "<leader>dk", dap.up, { desc = "[d]AP: Travel up the stacktrace" })
	map("n", "<leader>do", dap.step_out, { desc = "[d]AP: Step [o]ut" })
	map("n", "<leader>dO", dap.step_over, { desc = "[d]AP: Step [O]ver" })
	map("n", "<leader>dP", dap.pause, { desc = "[d]AP: Pause session." })
	map("n", "<leader>dr", require("dap").repl.toggle, { desc = "[d]AP: Toggle [r]EPL." })
	map("n", "<leader>dt", dap.terminate, { desc = "[d]AP: [t]erminate session." })
	map("n", "<leader>du", require("dapui").toggle, { desc = "[d]AP: Toggle UI" })

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

	-- Setup Icons
	local deficon = function(sign, symbol)
		vim.fn.sign_define(sign, {
			text = symbol,
			texthl = "",
			linehl = "",
			numhl = "",
		})
	end

	deficon("DapBreakpoint", "B")
	deficon("DapBreakpointCondition", "C")
	deficon("DapLogPoint", "L")
	deficon("DapStopped", "→")
	deficon("DapBreakpointRejected", "R")

	-- Load project config via launch.json
	vscode.json_decode = function(str)
		return vim.json.decode(json.json_strip_comments(str))
	end

	-- local codelldb = require("plugins.debuggers.codelldb")
	-- local rdbg = require("plugins.debuggers.rbdg")

	-- dap.adapters.codelldb = codelldb.adapter
	-- dap.adapters.ruby = rdbg.adapter
	-- dap.configurations.ruby = rdbg.config
	-- dap.configurations.rust = codelldb.config
end

return {
	{
		"mfussenegger/nvim-dap",
		recommended = true,
		desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",
		config = config,
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"rcarriga/nvim-dap-ui",
				config = function() end,
				dependencies = { "nvim-neotest/nvim-nio" },
			},
			-- virtual text for the debugger
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
			{
				"jay-babu/mason-nvim-dap.nvim",
				dependencies = "mason.nvim",
				cmd = { "DapInstall", "DapUninstall" },
				config = function() end,
			},
		},
	},
}
