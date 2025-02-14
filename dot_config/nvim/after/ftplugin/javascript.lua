local util = require("util")

local bufnr = vim.api.nvim_get_current_buf()

local root_dir = vim.fs.root(bufnr, { "eslint.config.mjs" })

-- clear out the spacing augroup.
vim.api.nvim_create_augroup("default_spacing", { clear = true })

vim.bo.shiftwidth = 2

util.ensure_installed("prettierd", function()
  util.enable_formatting(bufnr, false)
end)

if root_dir then
  util.ensure_installed("eslint-lsp", function()
    local cmd = util.mason_path() .. "/vscode-eslint-language-server"

    local approve_eslint = function(_, result)
      if result then
        return 4 -- approved
      end
    end

    local warn_probe_fail = function()
      vim.notify("[lsp] ESLint probe failed.", vim.log.levels.WARN)
      return {}
    end

    local warn_no_lib = function()
      vim.notify("[lsp] Unable to find ESLint library.", vim.log.levels.WARN)
      return {}
    end

    vim.lsp.start({
      name = "eslint",
      capabilities = vim.lsp.protocol.make_client_capabilities(),
      cmd = { cmd, "--stdio" },
      filetypes = { "javascript" },
      handlers = {
        ["eslint/confirmESLintExecution"] = approve_eslint,
        ["eslint/probeFailed"] = warn_probe_fail,
        ["eslint/noLibrary"] = warn_no_lib,
      },
      on_init = util.add_cmp_capabilities,
      root_dir = root_dir,
      settings = {
        validate = "on",
        packageManager = nil,
        useESLintClass = false,
        experimental = {
          useFlatConfig = false,
        },
        codeActionOnSave = {
          enable = false,
          mode = "all",
        },
        format = false,
        quiet = false,
        onIgnoredFiles = "off",
        rulesCustomizations = {},
        run = "onType",
        problems = {
          shortenToSingleLine = false,
        },
        nodePath = "",
        workingDirectory = { mode = "location" },
        codeAction = {
          disableRuleComment = {
            enable = true,
            location = "seperateLine",
          },
          showDocumentation = {
            enable = true,
          },
        },
      },
    })
  end)
end
