local M = {}

M.cmp = require("config.nvim-cmp").config
M.conform = require("config.conform").config
M.dap = require("config.nvim-dap").config
M.dapui = require("config.nvim-dap-ui").config
M.diagnostics = require("config.diagnostics").config
M.neotree = require("config.neo-tree").config
M.treesitter = require("config.treesitter").config
M.trouble = require("config.trouble").config

return M
