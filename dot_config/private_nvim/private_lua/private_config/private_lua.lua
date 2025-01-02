local M = {}

local function lua_default_settings()
	return {
		diagnostics = {
			globals = { "vim" },
		},

		-- Tell the language server which version of Lua
		-- you're using (most likely LuaJIT in the case of Neovim)
		runtime = {
			version = "LuaJIT",
		},

		-- Make the server aware of Neovim runtime files
		workspace = {
			checkThirdParty = false,
			library = {
				vim.env.RUNTIME,
			},
		},
	}
end

local function on_lua_init(client)
	local root = client.workspace_folders[1].name

	-- I will only ever use one settings file format.
	local settings_path = root .. "/.luarc.json"

	-- skip if there are local settings.
	if not (vim.uv or vim.loop).fs_stat(settings_path) then
		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, lua_default_settings())

		client.notify("workspace/didChangeConfiguration", {
			settings = client.config.settings,
		})
	end
end

-- This installs the tools that we use via Mason.
-- Put this in after/ftplugin/lua.lua so that it
-- only gets run when we open a lua file.
-- no need to install everything on the first run of neovim :)
M.install_tools = function()
	require("mason-tool-installer").setup({
		ensure_installed = { "stylua", "lua_ls" },
	})
end

-- This should get hooked into lspconfig,
-- this does get run... but not attached when lspconfig configures itself
-- so be warned.
M.lsp_setup = function()
	-- set the formatter.
	require("conform").formatters_by_ft.lua = { "stylua" }

	-- Setup the lsp.
	require("lspconfig").lua_ls.setup({
		on_init = on_lua_init,
		settings = {
			Lua = {},
		},
	})
end

return M
