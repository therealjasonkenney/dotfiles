--- Much of this was fetched from https://github.com/neovim/nvim-lspconfig/blob/master/lsp/rust_analyzer.lua

local function before_init(init_params, config)
  if config.settings and config.settings["rust-analyzer"] then
    init_params.initializationOptions = config.settings["rust-analyzer"]
  end

  ---@param command table{title: string, command: string, arguments: any[] }
  vim.lsp.commands["rust-analyzer.runSingle"] = function(command)
    local r = command.arguments[1]
    local cmd = { "cargo", unpack(r.args.cargoArgs) }
    if r.args.executableArgs and #r.args.executableArgs > 0 then
      vim.list_extend(cmd, { "--", unpack(r.args.executableArgs) })
    end

    local proc = vim.system(cmd, { cwd = r.args.cwd, env = r.args.environment })

    local result = proc:wait()

    if result.code == 0 then
      vim.notify(result.stdout, vim.log_levels.INFO)
    else
      vim.notify(result.stderr, vim.log_levels.ERROR)
    end
  end
end

local function on_attach(_, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, "LspCargoReload", function()
    local clients =
      vim.lsp.get_clients({ bufnr = bufnr, name = "rust_analyzer" })

    for _, client in ipairs(clients) do
      vim.notify("Reloading Cargo Workspace")

      ---@diagnostic disable-next-line:param-type-mismatch
      client:request("rust-analyzer/reloadWorkspace", nil, function(err)
        if err then
          error(tostring(err))
        end
        vim.notify("Cargo workspace reloaded")
      end, 0)
    end
  end, { desc = "Reload current cargo workspace" })
end

local function project_settings(root_dir)
  if not root_dir then
    return {}
  end

  local filepath = root_dir .. "/.rust-analyzer.json"

  if vim.fn.filereadable(filepath) == 0 then
    return {}
  end

  local content_lines = vim.fn.readfile(filepath)
  local content = table.concat(content_lines, "\n")

  return vim.json.decode(content)
end

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

local cmd = vim.fn.expand("$HOME/.local/cargo/bin/rust-analyzer")

local gbl_settings = {
  cargo = {
    features = "all",
  },
  cfg = {
    setTest = false,
  },
  lens = {
    debug = { enable = true },
    enable = true,
    implementations = { enable = true },
    references = {
      adt = { enable = true },
      enumVariant = { enable = true },
      method = { enable = true },
      trait = { enable = true },
    },
    run = { enable = true },
    updateTest = { enable = true },
  },
}

local root_dir = workspace_root()

local settings =
  vim.tbl_deep_extend("force", gbl_settings, project_settings(root_dir))

---@type vim.lsp.ClientConfig
return {
  before_init = before_init,
  capabilities = {
    experimental = {
      serverStatusNotification = true,
      commands = {
        commands = {
          "rust-analyzer.showReferences",
          "rust-analyzer.runSingle",
          "rust-analyzer.debugSingle",
        },
      },
    },
  },
  cmd = { cmd },
  filetypes = { "rust" },
  on_attach = on_attach,
  on_init = util.add_cmp_capabilities,
  root_dir = root_dir,
  settings = {
    ["rust-analyzer"] = settings,
  },
}
