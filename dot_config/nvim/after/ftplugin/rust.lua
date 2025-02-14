local function workspace_root()
  local bufnr = vim.api.nvim_get_current_buf()
  local cargo_root_dir = vim.fs.root(bufnr, { "Cargo.toml" })

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

local util = require("util")

vim.bo.shiftwidth = 4

local bufnr = vim.api.nvim_get_current_buf()

local rust_analyzer = vim.fn.expand("$HOME/.local/cargo/bin/rust-analyzer")

local root_dir = workspace_root()

if root_dir and vim.fn.filereadable(root_dir .. "/.vscode/launch.json") then
  util.ensure_installed("codelldb", function()
    local dap = require("dap")

    -- codelldb default configuration.
    dap.adapters.codelldb = {
      type = "executable",
      command = util.mason_path() .. "/codelldb",
    }

    util.enable_dap(bufnr)
  end)
end

if root_dir then
  local cmp = require("cmp")

  cmp.setup.buffer({ enabled = true })

  -- Settings are loaded from ./rust-analyzer.toml
  vim.lsp.start({
    name = "rust-analyzer",
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    cmd = { rust_analyzer },
    filetypes = { "rust" },
    on_init = util.add_cmp_capabilities,
    root_dir = root_dir,
  })

  util.enable_formatting(bufnr, true)
end
