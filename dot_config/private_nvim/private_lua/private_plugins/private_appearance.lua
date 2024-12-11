local function config()
	vim.cmd("colorscheme PaperColorSlim")
	vim.o.guifont = "Hack:h24"
end

return {
	{
		"pappasam/papercolor-theme-slim",
		priority = 1000,
		config = config,
	},
	{
		"vimpostor/vim-lumen",
	},
}
