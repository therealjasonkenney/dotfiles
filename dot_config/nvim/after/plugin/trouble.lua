local augroup = vim.api.nvim_create_augroup("trouble", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("trouble").setup({
      modes = {
        diagnostics_buffer = {
          mode = "diagnostics",
          filter = { buf = 0 },
          auto_open = false,
          open_no_results = true,
          pinned = true,
          warn_no_results = false,
        },
      },
    })
  end,
  desc = "Configure trouble",
  group = augroup,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(args)
    local map = vim.keymap.set
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Unlikly, but in the event the client is not present, just exit.
    if not client then
      return
    end

    -- If the client supports it, use trouble for incoming calls.
    if client.supports_method("callHierarchy/incomingCalls") then
      map("n", "gci", function()
        vim.cmd.Trouble({ "lsp_incoming_calls", "toggle" })
      end, { desc = "Display incoming calls." })
    end

    -- If the client supports it, use trouble for outgoing calls.
    if client.supports_method("callHierarchy/outgoingCalls") then
      map("n", "gco", function()
        vim.cmd.Trouble({ "lsp_outgoing_calls", "toggle" })
      end, { buffer = args.buf, desc = "Display outgoing calls." })
    end

    -- If the client supports it, use trouble for document symbols.
    if client.supports_method("textDocument/documentSymbol") then
      map("n", "gO", function()
        vim.cmd.Trouble({ "symbols", "toggle" })
      end, { buffer = args.buf, desc = "Display document symbols." })
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
        buffer = args.buf,
        desc = "Display document definitions, implementations and references",
      })
    end

    -- If the client supports it, enable keymaps for trouble for diagnostics
    if client.supports_method("textDocument/diagnostic") then
      map("n", "<leader>xx", function()
        vim.cmd.Trouble({ "diagnostics", "toggle" })
      end, { buffer = args.buf, desc = "Project diagnostics" })

      map("n", "<leader>xX", function()
        vim.cmd.Trouble({ "diagnostics_buffer", "toggle" })
      end, { buffer = args.buf, desc = "Open diagnostics buffer" })
    end
  end,
  desc = "Use trouble for diagnostics and lsp data",
})

vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    vim.cmd.Trouble({ "close" })
  end,
  group = augroup,
  desc = "On quit close all trouble windows",
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function()
    vim.cmd.Trouble({ "qflist", "open" })
  end,
  group = augroup,
  desc = "Open trouble when messages are posted to the quick-fix list",
})
