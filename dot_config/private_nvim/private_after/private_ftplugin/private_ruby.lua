local lsp = vim.lsp
local util = require("util")

local bufnr = vim.api.nvim_get_current_buf()

util.ensure_installed("rubyfmt")

-- Get executable paths, ruby uses asdf version manager which makes
-- shims, this is still... dangerous because the shims might get
-- their wires crossed, but I have yet to think of a better solution
-- for the moment :(
local bundle = vim.fn.expand("$HOME/.local/share/asdf/shims/bundle")
local rspec = vim.fn.expand("$HOME/.local/share/asdf/shims/rspec")
local ruby = vim.fn.expand("$HOME/.local/share/asdf/shims/ruby")

-- If we have a solargraph config, we should assume solargraph has been installed
-- and we will then start an LSP. I might add support to start rubocop or ruby_lsp
-- if I ever use them.
local solargraph_config = vim.fs.root(bufnr, { ".solargraph.yml" })

if solargraph_config then
  local cmp = require("cmp_nvim_lsp")
  local dap = require("dap")

	local capabilities = cmp.default_capabilities(lsp.protocol.make_client_capabilities())

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

	vim.lsp.start({
		name = "ruby",
		capabilities = capabilities,
		cmd = { bundle, "exec", "solargraph", "stdio" },
		init_options = { formatting = false },
		filetypes = { "ruby" },
		root_dir = solargraph_config,
	})

	-- We can add other ruby specific config here like trouble diagnostics or
	-- some form of documentation lookup o.0?
end

