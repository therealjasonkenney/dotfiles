local function init()
	-- Sets the formatexpr which in turn hooks into
	-- neovim's formatting keybindings/etc.
	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	init = init,
	dependencies = {
		"williamboman/mason.nvim",
		"zapling/mason-conform.nvim",
	},
	opts = {
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = {
			timeout_ms = 500,
		},
	},
}
