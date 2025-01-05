local function on_attach(ev)
	local builtin = require("telescope.builtin")
	local keybinds = require("keybinds")
	local bufnr = ev.buffer

	local opts = { buffer = bufnr }

	-- Use LSP for these.
	keybinds.set_code_action("n", vim.lsp.buf.code_action, opts)

	keybinds.set_goto_declaration("n", vim.lsp.buf.declaration, opts)
	keybinds.set_prev_diagnostic("n", vim.diagnostic.get_prev, opts)
	keybinds.set_next_diagnostic("n", vim.diagnostic.get_next, opts)
	keybinds.set_rename("n", vim.lsp.buf.rename, opts)
	keybinds.set_show_hover("n", vim.lsp.buf.hover, opts)
	keybinds.set_open_float("n", vim.diagnostic.open_float, opts)

	-- Use telescope for some stuff here.
	keybinds.set_goto_definition("n", builtin.lsp_definitions, opts)
	keybinds.set_goto_type_def("n", builtin.lsp_type_definitions, opts)
	keybinds.set_goto_references("n", builtin.lsp_references, opts)
	keybinds.set_show_diagnostics("n", function()
		builtin.diagnostics({ bufnr = bufnr })
	end, opts)
end

local function config()
	local lspconfig = require("lspconfig")

	local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

	lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, {
		capabilities = capabilities,
		on_attach = on_attach,
	})

	require("config.lua").lsp_setup()
end

return {
	-- Language servers and installation.
	{
		"neovim/nvim-lspconfig",
		config = config,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim",
			"lbrayner/vim-rzip", -- required for tsserver & yarn to behave.
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = "williamboman/mason.nvim",
	},
}
