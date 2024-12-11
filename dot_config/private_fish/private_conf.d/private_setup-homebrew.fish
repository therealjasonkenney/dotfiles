# Homebrew is the package manager I use for MacOS
# developer tooling.
# This config runs homebrew's setup which configures PATH, MANPATH, etc.
set -q __fish_config_sourced; and exit

status is-interactive; type -q brew; and begin
  brew shellenv | source
end
