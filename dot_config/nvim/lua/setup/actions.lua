-- ----------------------------------------------------------------------------
-- ## Editor Settings
-- * Map J and K to move selected text as a group.
-- * Map <leader>s to start substitution at cursor.
-- * Keep cursor at location when joining lines.
-- * Always confirm when exiting neovim.
-- * Enable mouse functionality.
-- * Intent with 2 spaces instead of tabs.
-- * Show Relative Line Numbers.
-- * Show hidden characters such as Tabs.
-- * Soft wrap a line, allow for breaking at whitespace.
--
-- ## Diagnostic Settings
-- * Disable diagnostic float (Use trouble instead).
-- * Do not sort by severity.
-- * Use nerd font glyphs for signs if able.
-- * Underline code with diagnostic messages.
-- * Do not update while editing.
-- * Use tiny-inline-diagnostic to render the messages instead.
-- * Virtual Text is disabled, otherwise we would render all
--   diagnostics at once.
--
-- ## Keymaps
-- |            |                                              |
-- | ---------- | -------------------------------------------- |
-- | `J`        | Move selection down                          |
-- | `K`        | Move selection up                            |
-- | `<space>s` | Search and replace word at cursor.           |
-- | `<space>y` | Copy text to system clipboard.               |
-- | `<space>Y` | Copy lines to system clipboard.              |
-- | `<space>p` | Append or swap from the system clipboard. |
-- | `<space>P` | Insert or replace from the system clipboard. |

-- Thanks to thePrimogen for some of these settings and maps
-- https://www.youtube.com/watch?v=w7i4amO_zaE
-- ----------------------------------------------------------------------------

local M = {}

local function setup_lsp(args)
  local util = require("util.lsp")
  local map = vim.keymap.set

  local augroup = vim.api.nvim_create_augroup("user.lsp", { clear = false })
  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)

  if not client then
    print("Client not found.")
    return
  end

  if client.supports_method("textDocument/codeAction") then
    util.enable_code_actions(bufnr, augroup)
  end

  if client.supports_method("textDocument/codeLens") then
    util.enable_codelens(bufnr, augroup)
  end

  -- If the client supports it, use trouble for incoming calls.
  if client.supports_method("callHierarchy/incomingCalls") then
    map("n", "gci", function()
      vim.cmd.Trouble({ "lsp_incoming_calls", "toggle" })
    end, { buffer = bufnr, desc = "Display incoming calls." })

    print("Enabled Trouble (incoming calls)")
  end

  -- If the client supports it, use trouble for outgoing calls.
  if client.supports_method("callHierarchy/outgoingCalls") then
    map("n", "gco", function()
      vim.cmd.Trouble({ "lsp_outgoing_calls", "toggle" })
    end, { buffer = bufnr, desc = "Display outgoing calls." })

    print("Enabled Trouble (outgoing calls)")
  end

  -- If the client supports it, use trouble for document symbols.
  if client.supports_method("textDocument/documentSymbol") then
    map("n", "gO", function()
      vim.cmd.Trouble({ "symbols", "toggle" })
    end, { buffer = bufnr, desc = "Display document symbols." })

    print("Enabled Trouble (Document Symbols)")
  end

  -- If the client supports it, use trouble for lsp information.
  if
    client.supports_method("textDocument/definition")
    or client.supports_method("textDocument/implementation")
    or client.supports_method("textDocument/references")
    or client.supports_method("textDocument/typeDefinition*")
  then
    map("n", "grr", function()
      vim.cmd.Trouble({ "lsp", "toggle" })
    end, {
      buffer = bufnr,
      desc = "Display document definitions, implementations and references",
    })

    print("Enabled Trouble (LSP)")
  end

  -- If the client supports it, enable keymaps for trouble for diagnostics
  if client.supports_method("textDocument/diagnostic") then
    map("n", "<leader>xx", function()
      vim.cmd.Trouble({ "diagnostics", "toggle" })
    end, { buffer = args.buf, desc = "Project diagnostics" })

    map("n", "<leader>xX", function()
      vim.cmd.Trouble({ "diagnostics_buffer", "toggle" })
    end, { buffer = args.buf, desc = "Open diagnostics buffer" })

    print("Enabled Trouble (Diag)")
  end

  if client.supports_method("textDocument/rename") then
    map("n", "grn", vim.lsp.buf.rename, {
      desc = "Rename all references to the symbol under the cursor",
      buffer = bufnr,
    })

    print("Enabled Rename")
  end

  if client.supports_method("textDocument/signatureHelp") then
    map("n", "<C-S>", vim.lsp.buf.signature_help, {
      desc = "Displays signature information about the symbol under the cursor in a floating window.",
      buffer = bufnr,
    })

    print("Enabled Signature Help")
  end
end

--- This needs to be loaded first, before anything else.
M.setup_colorscheme = function()
  require("mini.deps").add("pappasam/papercolor-theme-slim")

  vim.cmd.colorscheme({ "PaperColorSlim" })
end

M.set_defaults = function()
  local icons = require("config").icons()
  local map = vim.keymap.set
  local opt = vim.opt

  -- Defaults, may be overridden in ftplugin files

  opt.confirm = true
  opt.linebreak = true
  opt.list = true -- this is how you show tabs.
  opt.number = true
  opt.mouse = "a"
  opt.relativenumber = true

  -- Set default indent to 2 spaces.
  -- Overridden in ftplugin files and editorconfig.
  opt.expandtab = true
  opt.shiftround = true
  opt.shiftwidth = 2
  opt.softtabstop = 2
  opt.tabstop = 2

  -- OS specific settings
  opt.shell = "/opt/homebrew/bin/fish"

  -- Diagnostics setup.
  vim.diagnostic.config({
    float = false,
    severity_sort = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.error,
        [vim.diagnostic.severity.WARN] = icons.warning,
        [vim.diagnostic.severity.INFO] = icons.info,
        [vim.diagnostic.severity.HINT] = icons.hint,
      },
    },
    underline = true,
    update_in_insert = false,
    virtual_text = false,
  })

  -- Setup LSP
  local augroup = vim.api.nvim_create_augroup("user.lsp", { clear = true })

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = setup_lsp,
    desc = "Setup LSP Defaults",
    group = augroup,
  })

  -- Move selected text as a group
  map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
  map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

  -- Keep cursor at location when joining lines.
  map("n", "J", "mzJ`z", { desc = "[J]oin lines." })

  -- Search and replace word at cursor.
  map(
    "n",
    "<leader>s",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    { desc = "Search and replace word at cursor" }
  )

  -- Note the + register is the system clipboard.
  map(
    { "n", "v", "o" },
    "<leader>y",
    "\"+y",
    { desc = "Copy to the system clipboard." }
  )

  map(
    { "n", "o" },
    "<leader>Y",
    "\"+Y",
    { desc = "Copy to the system clipboard." }
  )

  map(
    { "n", "o" },
    "<leader>p",
    "\"+p",
    { desc = "Append from the system clipboard" }
  )

  map(
    { "n", "o" },
    "<leader>P",
    "\"+P",
    { desc = "Insert from the system clipboard" }
  )

  map(
    "v",
    "<leader>p",
    "\"+p",
    { desc = "Swap text with the system clipboard" }
  )

  map("v", "<leader>P", "\"+P", { desc = "Replace from the system clipboard" })
end

return M
