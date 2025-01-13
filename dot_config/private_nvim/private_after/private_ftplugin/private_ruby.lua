local cmp = require("cmp_nvim_lsp")
local conform = require("conform")
local dap = require("dap")
local lsp = vim.lsp
local util = require("util")

local bundle = vim.fn.expand("$HOME/.local/share/asdf/shims/bundle")

util.ensure_installed("rubyfmt")

-- If we have a solargraph config, we should assume solargraph has been installed
-- and we will then start an LSP. I might add support to start rubocop or ruby_lsp
-- if I ever use them.
local solargraph_config = vim.fs.root(bufnr, { ".solargraph.yml" })

if solargraph_config then
	local capabilities = cmp.default_capabilities(lsp.protocol.make_client_capabilities())

	vim.lsp.start({
		name = "ruby",
		capabilities = capabilities,
		cmd = bundle,
		args = { "exec", "solargraph", "stdio" },
		init_options = { formatting = false },
		filetypes = { "ruby" },
		root_dir = solargraph_config,
	})

	-- We can add other ruby specific config here like trouble diagnostics or
	-- some form of documentation lookup o.0?
end

-- Setup formatter
conform.formatters_by_ft.ruby = { "rubyfmt" }

-- Setup debugger to use rbdg.
local rspec = vim.fn.expand("$HOME/.local/share/asdf/shims/rspec")
local ruby = vim.fn.expand("$HOME/.local/share/asdf/shims/ruby")

dap.configurations.ruby = {
	{
		type = "ruby",
		name = "debug current file",
		request = "attach",
		localfs = true,
		command = ruby,
		script = "${file}",
	},
	{
		type = "ruby",
		name = "run current spec file",
		request = "attach",
		localfs = true,
		command = rspec,
		script = "${file}",
	},
}

dap.adapters.ruby = function(callback, config)
	callback({
		type = "server",
		host = "127.0.0.1",
		port = "${port}",
		executable = {
			command = bundle,
			args = {
				"exec",
				"rdbg",
				"-n",
				"--open",
				"--port",
				"${port}",
				"-c",
				"--",
				"bundle",
				"exec",
				config.command,
				config.script,
			},
		},
	})
end
