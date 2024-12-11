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

function M.on_setup()
  require("lspconfig").lua_ls.setup({
    on_init = on_lua_init,
    settings = {
      Lua = {},
    },
  })
end

return M
