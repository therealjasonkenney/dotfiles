local M = {}

local path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

---Loads the user added words into a dictionary.
---@return table dictionary
M.load_dictionary = function()
  local dictionary = {}

  local f = io.open(path, "r")

  if not f then
    return {}
  end

  for word in f:lines() do
    table.insert(dictionary, word)
  end

  return dictionary
end

return M
