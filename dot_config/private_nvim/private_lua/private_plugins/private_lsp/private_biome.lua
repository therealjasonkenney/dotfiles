local M = {}

function M.on_setup()
  require("lspconfig").biome.setup({
    filetypes = {
      "css",
      "graphql",
      "javascript",
      "javascriptreact",
      "json",
      "jsonc",
      "typescript",
      "typescript.tsx",
      "typescriptreact",
    },
  })
end

return M
