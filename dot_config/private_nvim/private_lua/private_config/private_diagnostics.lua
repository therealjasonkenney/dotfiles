local function float_prefix(diagnostic, i, total)
	local prefixes = {}

	prefixes[vim.diagnostic.severity.ERROR] = "E"
	prefixes[vim.diagnostic.severity.HINT] = "H"
	prefixes[vim.diagnostic.severity.INFO] = "I"
	prefixes[vim.diagnostic.severity.WARN] = "W"

	local format = "[%1s (%02d/%02d)]: "
	local sign = prefixes[diagnostic.severity]

	return string.format(format, sign, i, total)
end

return {
	setup = function()
		vim.diagnostic.config({
			float = {
				border = "rounded",
				source = true,
				header = "Diagnostics\n--------",
				prefix = float_prefix,
			},
			severity_sort = false,
			signs = true,
			underline = true,
			update_in_insert = false,
			virtual_text = false,
		})
	end,
}
