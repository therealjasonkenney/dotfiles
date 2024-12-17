#!/usr/bin/env sh

echo "Installing Ruby 3.3"

ASDF_DIR="$HOME/.local/share/asdf"
ASDF_DATA_DIR="$ASDF_DIR"
ASDF_GEM_DEFAULT_PACKAGES_FILE="$HOME/.config/asdf/default-gems"

OS=$(uname -s)

# Homebrew on OSX puts everything in /opt/homebrew
# Linux puts everything in /usr/local/bin
if [ "$OS" = "Darwin" ]; then
  FISH="/opt/homebrew/bin/fish"
else
  FISH="/usr/local/bin/fish"
fi

# Install ASDF if it does not exist.
if [ ! -d "$ASDF_DIR" ]; then
  echo "Installing ASDF"
  git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR" --branch v0.14.1
fi

# Set universal variables in fish.
# These have ASDF conform to XDG specs (All things in ~/.config and ~/.local)
$FISH -c 'set -Ux ASDF_DIR          "$HOME/.local/share/asdf"'
$FISH -c 'set -Ux ASDF_DATA_DIR     "$ASDF_DIR"'
$FISH -c 'set -Ux ASDF_CONFIG_FILE  "$HOME/.config/asdf/asdfrc"'
$FISH -c 'set -Ux ASDF_GEM_DEFAULT_PACKAGES_FILE "$HOME/.config/asdf/default-gems"'

# Load ASDF
. "$ASDF_DIR/asdf.sh"

# Install Ruby Plugin
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git

# Install Ruby 3.3
asdf install ruby latest
asdf global ruby latest
