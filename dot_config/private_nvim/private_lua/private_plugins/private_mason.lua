local function config()
  require("mason").setup({
    build = ":MasonUpdate",
  })

  require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
      "vale_ls", -- Markdown and TeX
    },
  })

  require("mason-tool-installer").setup({
    ensure_installed = { "stylua" },
  })
end

return {
  "williamboman/mason.nvim",
  config = config,
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
}
