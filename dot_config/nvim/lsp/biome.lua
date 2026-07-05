local util = require("util")

---@type vim.lsp.ClientConfig
return {
  cmd = util.mason_cmd("biome"),
  name = "biome",
  filetypes = {
    "astro",
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "svelte",
    "typescript",
    "typescriptreact",
    "vue"
  },
  root_markers = { "package.json" }
}
