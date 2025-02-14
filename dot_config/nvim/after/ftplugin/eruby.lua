-- ----------------------------------------------------------------------------
-- # 󰴭 Ruby ERB Configuration
--
-- ## Settings
-- |              |                       |                     |
-- | ------------ | --------------------- | ------------------- |
-- | Indent width | 2                     | Tabs are spaces     |
-- | Formatter    | `erb-formatter`       | Installed via asdf  |
--
-- ## Autocompletion
-- * Treesitter
-- * LuaSnips Snippets
--
-- ----------------------------------------------------------------------------
local util = require("util")

local bufnr = vim.api.nvim_get_current_buf()

util.enable_formatting(bufnr, false)
