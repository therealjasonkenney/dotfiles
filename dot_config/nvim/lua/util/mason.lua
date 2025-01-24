-- Utilities for my neovim config.

local M = {}

local notifier = function(msg, level, title)
  return vim.schedule_wrap(function()
    vim.notify(msg, level, { title = title })
  end)
end

---comment ensures a tool is installed via mason.
---See: https://github.com/mason-org/mason-registry
---@param name string tool name as found in mason-registry
---@param on_installed function callback that when the tool is installed.
M.ensure_installed = function(name, on_installed)
  local reg = require("mason-registry")

  local on_fail = notifier(
    string.format("%s: install failed", name),
    vim.log.levels.ERROR,
    "mason"
  )

  local on_success =
    notifier(string.format("%s: installed", name), vim.log.levels.INFO, "mason")

  reg.refresh(function()
    local pkg = reg.get_package(name)

    if not pkg:is_installed() then
      pkg:once("install:failed", on_fail)
      pkg:once("install:success", on_success)
      pkg:once("install:success", function()
        vim.schedule(on_installed)
      end)
      pkg:install({})
    else
      on_installed()
    end
  end)
end

---The directory containing tools installed by mason.
---Currently only supports POSIX operating systems.
---@return string
M.mason_path = function()
  return vim.fn.expand("$HOME/.local/share/nvim/mason/bin")
end

return M
