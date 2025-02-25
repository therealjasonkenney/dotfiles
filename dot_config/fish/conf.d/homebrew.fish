# Homebrew is the package manager I use for MacOS
# developer tooling.

type -q /opt/homebrew/bin/brew; and begin
  # This config runs homebrew's setup which configures PATH, MANPATH, etc.
  /opt/homebrew/bin/brew shellenv | source
end

status is-interactive; and type -q /opt/homebrew/bin/brew; and begin
  # This is for when you want to call brew bundle install, it will
  # use this file (installed by chezmoi) as the default.
  set -gx HOMEBREW_BUNDLE_FILE_GLOBAL {$HOME}/.config/brewfile/Brewfile
end
