# Only load if its Interactive
status is-interactive; and type -q zellij; and begin
  set -gx ZELLIJ_CONFIG_DIR {$HOME}/.config/zellij
end
