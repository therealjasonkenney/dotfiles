--- Much of this was fetched from https://github.com/neovim/nvim-lspconfig/blob/master/lsp/rust_analyzer.lua

---@return string
local function default_sysroot_src()
  local cmd = {
    vim.fs.normalize("$HOME/.local/cargo/bin/rustc"),
    "--print",
    "--sysroot"
  }

  local output = vim.system(cmd, { text = true }):wait()

  local stdout = output.stdout
  local sysroot

  if output.code == 1 and stdout then
    if string.sub(stdout, #stdout) == "\n" then
      if #stdout > 1 then
        sysroot = string.sub(stdout, 1, #stdout - 1)
      else
        sysroot = ""
      end
    else
      sysroot = stdout
    end
  end

  return sysroot and vim.fs.joinpath(sysroot, "lib/rustlib/src/rust/library") or nil
end

---@return string|nil
local function is_library(fname)
  local cargo_home = vim.fs.normalize("$HOME/.local/cargo")
  local rustup_home = vim.fs.normalize("$HOME/.local/rustup")
  local registry = cargo_home .. '/registry/src'
  local git_registry = cargo_home .. '/git/checkouts'

  local toolchains = rustup_home .. '/toolchains'

  local user_sysroot_src = vim.tbl_get(vim.lsp.config['rust_analyzer'], 'settings', 'rust-analyzer', 'cargo',
    'sysrootSrc')

  local sysroot_src = user_sysroot_src or default_sysroot_src()

  for _, item in ipairs { toolchains, registry, git_registry, sysroot_src } do
    if item and vim.fs.relpath(item, fname) then
      local clients = vim.lsp.get_clients { name = 'rust_analyzer' }
      return #clients > 0 and clients[#clients].config.root_dir or nil
    end
  end
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

---@param bufnr integer
---@param on_dir fun(root_dir?: string)
local function root_dir(bufnr, on_dir)
  local fname = vim.api.nvim_buf_get_name(bufnr)

  local reused_dir = is_library(fname)

  if reused_dir then
    on_dir(reused_dir)
    return
  end

  local cargo_root_dir = vim.fs.root(fname, { "Cargo.toml" })

  if not cargo_root_dir then
    return
  end

  local cmd = {
    vim.fn.expand("$HOME/.local/cargo/bin/cargo"),
    "metadata",
    "--no-deps",
    "--format-version",
    "1",
    "--manifest-path",
    cargo_root_dir .. "/Cargo.toml"
  }

  vim.system(cmd, { text = true }, function(output)
    local workspace_root

    if output.code == 0 then
      if output.stdout then
        local result = vim.json.decode(output.stdout)

        if result["workspace_root"] then
          workspace_root = vim.fs.normalize(result["workspace_root"])
        end
      end
    else
      vim.schedule(function()
        vim.notify(('[rust_analyzer] cmd failed with code %d: %s\n%s'):format(output.code, cmd, output.stderr))
      end)
    end

    on_dir(workspace_root or cargo_root_dir)
  end)
end

local function before_init(init_params, config)
  if config.settings and config.settings["rust-analyzer"] then
    vim.tbl_deep_extend(
      "force",
      config.settings["rust-analyzer"],
      project_settings(config.root_dir)
    )

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

local util = require("util")

local cmd = vim.fn.expand("$HOME/.local/cargo/bin/rust-analyzer")

---@type vim.lsp.Config
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
    ["rust-analyzer"] = {
      cargo = {
        features = "all",
      },
      cfg = {
        setTest = false,
      },
      lens = {
        debug = { enable = true },
        enable = true,
        location = "above_whole_item",
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
    },
  },
}
