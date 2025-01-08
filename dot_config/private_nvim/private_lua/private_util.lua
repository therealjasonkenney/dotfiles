-- Utilities for my neovim config.

local M = {}

local notifier = function(msg, level, title)
	return vim.schedule_wrap(function()
		vim.notify(msg, level, { title = title })
	end)
end

---comment ensures a tool is installed via mason.
---See: https://github.com/mason-org/mason-registry
---@param name string tool name as found in mason-registry
M.ensure_installed = function(name)
	local reg = require("mason-registry")

	local on_fail = notifier(string.format("%s: install failed", name), vim.log.levels.ERROR, "mason")

	local on_success = notifier(string.format("%s: installed", name), vim.log.levels.INFO, "mason")

	reg.refresh(function()
		local pkg = reg.get_package(name)

		if not pkg:is_installed() then
			pkg:once("install:failed", on_fail)
			pkg:once("install:success", on_success)
			pkg:install({})
		end
	end)
end

---Finds the first parent directory containing a file in file_list
---for the current buffer.
---
---Used for LSP configuration
---@param file_list string[]
---@return string | nil
M.get_root_dir = function(file_list)
	local bufnr = vim.api.nvim_get_current_buf()

	return vim.fs.root(bufnr, file_list)
end

---comment Checks and returns true if a floating window is already open.
---@return boolean
M.is_float_open = function()
	local windows = vim.api.nvim_tabpage_list_wins(0)

	for _, winid in pairs(windows) do
		-- if the zindex is truthy, then there is a float open.
		if vim.api.nvim_win_get_config(winid).zindex then
			return true
		end
	end

	return false
end

---The directory containing tools installed by mason.
---Currently only supports POSIX operating systems.
---@return string
M.mason_path = function()
	return vim.fn.expand("$HOME/.local/share/nvim/mason/bin")
end

return M
