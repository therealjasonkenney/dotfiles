-- Automatically enables/disables hlsearch when moving in and out of searches.

local function config()
  require("auto-hlsearch").setup()
end

return {
  {
    "asiryk/auto-hlsearch.nvim",
    config = config,
  },
}
