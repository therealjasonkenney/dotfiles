-- Both LSP and Rustaceanvim might want to set the same keybinds.

local function set_keybind(key, desc)
  local function f(mode, action, opts)
    opts.desc = desc
    vim.keymap.set(mode, key, action, opts)
  end

  return f
end

return {
  set_code_action = set_keybind("gra", "List code actions"),
  set_debugger_toggle_breakpoint = set_keybind("<leader>dt", "Toggle Breakpoint"),
  set_debugger_continue = set_keybind("<leader>dc", "Continue from breakpoint"),
  set_format = set_keybind("gq", "Format text"),
  set_file_browse = set_keybind("fb", "Show file browser"),
  set_file_list = set_keybind("fl", "List Files"),
  set_file_search = set_keybind("fs", "Search files."),
  set_goto_definition = set_keybind("gd", "Goto definition"),
  set_goto_declaration = set_keybind("gD", "Goto declaration"),
  set_goto_implementations = set_keybind("gi", "Goto implementations"),
  set_goto_type_def = set_keybind("go", "Jump to type definition"),
  set_goto_references = set_keybind("grr", "List all references"),
  set_next_diagnostic = set_keybind("d]", "Goto next diagnostic"),
  set_open_float = set_keybind("<leader>l", "Open diagnostics float"),
  set_prev_diagnostic = set_keybind("[d", "Goto previous diagnostic"),
  set_rename = set_keybind("grn", "Rename all referneces to the symbol"),
  set_show_diagnostics = set_keybind("gl", "Show diagnostics"),
  set_show_macro = set_keybind("gm", "Show expanded macro"),
  set_show_hover = set_keybind("K", "Open hover window"),
  set_show_keys = set_keybind("<leader>?", "Show keymaps"),
  set_show_signature = set_keybind("gs", "Display signature information"),
}
