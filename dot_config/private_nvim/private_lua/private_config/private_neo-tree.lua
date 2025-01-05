local M = {}

M.plugin_opts = function()
	return {
		default_component_configs = {
			git_status = {
				symbols = {
					added = "[a]",
					deleted = "[d]",
					modified = "[m]",
					renamed = "[r]",
					untracked = "?",
					ignored = "",
					unstaged = "!",
					staged = "+",
					conflict = "c",
				},
			},
			icon = {
				folder_closed = "[ ]",
				folder_open = "[>]",
				folder_empty = "[-]",
				default = "-",
			},
			indent = {
				expander_collapsed = "",
				expander_expanded = "",
			},
		},
	}
end

return M
