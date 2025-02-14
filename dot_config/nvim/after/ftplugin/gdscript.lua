-- ----------------------------------------------------------------------------
-- Godot script Configuration.
-- ## Settings
--
-- |              |                       |                     |
-- | ------------ | --------------------- | ------------------- |
-- | Indent width | 4                     | Tabs are spaces     |
-- | Debugger     | `godot`               |                     |
-- | Formatter    | `godot`               | Included with GODOT |
-- | LSP          | `godot`               | Included with GODOT |
-- | Root         | `project.godot`       |                     |
--
-- ## Autocompletion
-- * Signature Help
-- * Treesitter
-- * LSP
-- * LuaSnips Snippets
-- * Friendly Snippets

-- ----------------------------------------------------------------------------
local util = require("util")

local bufnr = vim.api.nvim_get_current_buf()
local port = os.getenv("GDScript_Port") or "6005"

local root_dir = vim.fs.root(bufnr, { "project.godot" })

if root_dir then
  local dap = require("dap")

  local cmd = vim.lsp.rpc.connect("127.0.0.1", tonumber(port))

  vim.lsp.start({
    name = "godot",
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    cmd = cmd,
    filetypes = { "gdscript", "gd", "gdscript3" },
    on_init = util.add_cmp_capabilities,
    root_dir = root_dir,
  })

  dap.adapters.godot = {
    type = "server",
    host = "127.0.0.1",
    port = 6006,
  }

  dap.configurations.gdscript = {
    {
      type = "godot",
      request = "launch",
      name = "Launch scene",
      project = "${workspaceFolder}",
      launch_scene = true,
    },
  }

  util.enable_dap(bufnr)
  util.enable_formatting(bufnr, true)
end
