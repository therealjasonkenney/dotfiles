local function set_formatexpr(ev)
	local bufnr = ev.buf

	-- Sets the formatexpr which in turn hooks into
	-- neovim's formatting keybindings/etc.
	vim.bo[bufnr].formatexpr = "v:lua.require'conform'.formatexpr()"
end

local function init()
	local augroup = vim.api.nvim_create_augroup("formatting", {})

	vim.api.nvim_create_autocmd("LspAttach", {
		desc = "Override format expression to use conform.",
		callback = set_formatexpr,
		group = augroup,
	})
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
		format_on_save = {
			timeout_ms = 500,
		},
	},
}
