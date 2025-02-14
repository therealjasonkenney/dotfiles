local M = {}

---Lets the lsp know about cmp's capabilities.
---@param client vim.lsp.Client
M.add_capabilities = function(client)
  local client_capabilities = client.capabilities
  local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

  client.capabilities =
    vim.tbl_deep_extend("force", client_capabilities, cmp_capabilities)
end

---Formats the cmp menu to use icons for lsp and sources.
---@module "cmp"
---@param entry cmp.Entry
---@param vim_item vim.CompletedItem
---@return vim.CompletedItem
M.cmp_format = function(entry, vim_item)
  local get_icon = require("mini.icons").get

  local icon, hl, is_default = get_icon("lsp", vim_item.kind)

  if is_default then
    -- If no icon is present, just highlight it for now.
    vim_item.kind_hl_group = "CmpItemKind" .. vim_item.kind
  else
    vim_item.kind = icon
    vim_item.kind_hl_group = hl
  end

  local default_menu = "[" .. entry.source.name .. "]"

  vim_item.menu = ({
    buffer = "[B ]",
    treesitter = "[TS]",
    nvim_lsp = "[LS]",
    nvim_lsp_signature_help = "[LS]",
    luasnip = "[S ]",
    friendly_snippets = "[S ]",
  })[entry.source.name] or default_menu

  return vim_item
end

---Ensures when selecting a cmp option that we don't just
---use the first selection while typing.
---@param fallback function
M.safe_select = function(fallback)
  local cmp = require("cmp")

  if cmp.visible() and cmp.get_active_entry() then
    cmp.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    })
  else
    fallback()
  end
end

return M
