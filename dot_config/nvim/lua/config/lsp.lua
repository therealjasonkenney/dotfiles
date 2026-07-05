---Lets the lsp know about cmp's capabilities.
---@param client vim.lsp.Client
local function add_cmp_capabilities(client)
  local client_capabilities = client.capabilities
  local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

  client.capabilities =
      vim.tbl_deep_extend("force", client_capabilities, cmp_capabilities)
end

local augroup = vim.api.nvim_create_augroup("user.lsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Setup Codelens",
  group = augroup,
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if not client then
      print("Client not found.")
      return
    end

    if client:supports_method("textDocument/codeLens", bufnr) then
      vim.lsp.codelens.enable(true)

      vim.keymap.set(
        "n",
        "<leader>cc",
        vim.lsp.codelens.run,
        { desc = "Run Codelens", buffer = bufnr }
      )
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Setup Formatting",
  group = augroup,
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if not client then
      print("Client not found.")
      return
    end

    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        desc = "Format on Save",
        group = augroup,
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end
  end,
})

vim.lsp.config("*", {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_init = add_cmp_capabilities,
})

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
