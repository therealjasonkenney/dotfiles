local M = {}

local function update_codeaction_glyph(bufnr)
  local ns = vim.api.nvim_create_namespace("user.codeactions")
  local sign_text = require("config").icons()["code_action"]

  local params =
    vim.tbl_deep_extend("force", vim.lsp.util.make_range_params(), {
      context = {
        diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr),
      },
    })

  local line = params.range.start.line
  local col = params.range.start.character

  vim.lsp.buf_request(
    bufnr,
    "textDocument/codeAction",
    params,
    function(_, actions, _)
      if vim.b[bufnr] == nil then
        return
      end

      local extmark_id = vim.b[bufnr].code_action_mark

      if actions and type(actions) == "table" and #actions > 0 then
        vim.b[bufnr].code_action_mark =
          vim.api.nvim_buf_set_extmark(bufnr, ns, line, col, {
            sign_text = sign_text,
            strict = false,
          })
      elseif extmark_id ~= nil then
        vim.api.nvim_buf_del_extmark(bufnr, ns, extmark_id)
      end
    end
  )
end

--- Sets keymap and sets codection glyphs to update.
---@param bufnr number
---@param augroup number
M.enable_code_actions = function(bufnr, augroup)
  vim.schedule(function()
    update_codeaction_glyph(bufnr)
  end)

  vim.keymap.set(
    "n",
    "gra",
    vim.lsp.buf.code_action,
    { buffer = bufnr, desc = "Show code actions." }
  )

  vim.api.nvim_create_autocmd("CursorMoved", {
    buffer = bufnr,
    callback = function()
      update_codeaction_glyph(bufnr)
    end,
    desc = "Update codeaction signs",
    group = augroup,
  })

  print("Enabled Code Actions")
end

---Enables Codelens
--- Sets autocmds to refresh the codelens when cursor is not moving or
--- when Insert Mode is left.
---
--- Adds keymap to run codelens.
---@param bufnr number
---@param augroup number
M.enable_codelens = function(bufnr, augroup)
  vim.schedule(function()
    vim.lsp.codelens.refresh({ bufnr = bufnr })
  end)

  vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
    buffer = bufnr,
    callback = function()
      vim.lsp.codelens.refresh({ bufnr = bufnr })
    end,
    desc = "Refresh codelens",
    group = augroup,
  })

  vim.keymap.set(
    "n",
    "<leader>cc",
    vim.lsp.codelens.run,
    { desc = "Run Codelens", buffer = bufnr }
  )

  print("Enabled Codelens")
end

return M
