return {
	{
		"hrsh7th/nvim-cmp",
		config = require("config.nvim-cmp").on_config,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			{
				"L3MON4D3/LuaSnip",
				version = "v2.3.0",
				dependencies = {
					"saadparwaiz1/cmp_luasnip",
					"rafamadriz/friendly-snippets",
				},
			},
		},
	},
}
