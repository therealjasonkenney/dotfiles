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

local root_dir = vim.fs.root(bufnr, { "project.godot" })

if root_dir then
  local dap = require("dap")

  local config = vim.lsp.config.godot

  vim.lsp.start(config, {
    bufnr = bufnr,
    _root_markers = config.root_markers,
    reuse_client = config.reuse_client,
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
