-- Spelling and grammar support.
-- TODO: Update to ltex-ls-plus when it gets
-- added to mason-registry.
local util = require("util")

---Loads the user added words into a dictionary.
---@return table dictionary
local function load_dictionary()
  local dictionary = {}

  local path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

  local f = io.open(path, "r")

  if not f then
    return {}
  end

  for word in f:lines() do
    table.insert(dictionary, word)
  end

  return dictionary
end

---@return vim.lsp.ClientConfig
return {
  cmd = util.mason_cmd("ltex-ls"),
  filetypes = { "markdown" },
  on_init = function(client)
    local dictionary = load_dictionary()
    client.settings.ltex.dictionary = {
      ["en-US"] = dictionary,
    }
  end,
  settings = {
    ltex = {
      dictionary = {},
      enabled = true,
      language = "en-US",
    }
  }
}
