local function config()
	require("mason").setup({
		build = ":MasonUpdate",
	})
end

return {
	"williamboman/mason.nvim",
	config = config,
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
}
