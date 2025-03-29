-- ---------------------------------------------------------------------------
-- LSP for Godot Script
-- ---------------------------------------------------------------------------

local host = os.getenv("GDSCRIPT_HOST") or "127.0.0.1"
local port = os.getenv("GDSCRIPT_PORT") or "6005"
local cmd = vim.lsp.rpc.connect(host, tonumber(port))

return {
  name = "godot",
  cmd = cmd,
  filetypes = { "gdscript", "gd", "gdscript3" },
  root_markers = { "project.godot" },
}
