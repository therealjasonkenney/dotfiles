local M = {}

M.enable_lsps = function()
  local dir = vim.fn.stdpath("config") .. "/lsp"

  local servers = {}

  if vim.fn.isdirectory(dir) == 1 then
    local files = vim.fn.readdir(dir)
    for _, file in ipairs(files) do
      if file:match("%.lua$") then
        local name = file:gsub("%.lua$", "")
        table.insert(servers, name)
      end
    end
  end

  if #servers > 0 then
    vim.lsp.enable(servers)
  end
end

return M
