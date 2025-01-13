local function workspace_root()
  local lsp_util = require("util.lsp")
  local cargo_root_dir = lsp_util.get_root_dir({ "Cargo.toml" })

  if cargo_root_dir then
    local get_root = vim.fn.expand("$HOME/.local/cargo/bin/cargo")
    get_root = get_root .. " metadata --no-deps --format-version 1"
    get_root = get_root .. " --manifest-path "
    get_root = get_root .. cargo_root_dir .. "/Cargo.toml"

    local pipe = assert(io.popen(get_root, "r"))

    local output = pipe:read("*all")

    pipe:close()

    if output then
      local data = vim.json.decode(output)

      if data["workspace_root"] then
        return vim.fs.normalize(data["workspace_root"])
      end
    end
  end
end

local lsp_util = require("util.lsp")
local util = require("util")

local rust_analyzer = vim.fn.expand("$HOME/.local/cargo/bin/rust-analyzer")

local root_dir = workspace_root()

print(root_dir)

if root_dir then
  local dap = require("dap")

  util.ensure_installed("codelldb")

  -- Settings are loaded from ./rust-analyzer.toml
  vim.lsp.start({
    name = "rust-analyzer",
    capabilities = lsp_util.default_capabilities(),
    cmd = { rust_analyzer },
    filetypes = { "rust" },
    root_dir = root_dir,
  })

  lsp_util.format_on_save()

  -- Debugging in rust.
  -- Settings should be loaded from ./.vscode/launch.json
  dap.adapters.codelldb = {
    type = "executable",
    command = util.mason_path() .. "/codelldb",
  }
end
