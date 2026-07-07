# ASDF manages the environments of several
# programming languages including ruby and elixir.

status is-interactive; and begin
  set -gx ASDF_DIR          {$HOME}/.local/share/asdf
  set -gx ASDF_DATA_DIR     {$ASDF_DIR}
  set -gx ASDF_CONFIG_FILE  {$HOME}/.config/asdf/asdfrc

  fish_add_path {$ASDF_DIR}/bin
  fish_add_path {$ASDF_DATA_DIR}/shims
end
