# Homebrew is the package manager I use for MacOS
# developer tooling.
# This config runs homebrew's setup which configures PATH, MANPATH, etc.

type -q /opt/homebrew/bin/brew; and begin
  set -gx HOMEBREW_BUNDLE_FILE_GLOBAL "$HOME/.config/brewfile/Brewfile"

  /opt/homebrew/bin/brew shellenv | source
end
