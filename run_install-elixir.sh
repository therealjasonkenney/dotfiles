#!/usr/bin/env sh

echo "Installing Elixir 1.17 for OTP 27"

ASDF_DIR="$HOME/.local/share/asdf"
ASDF_DATA_DIR="$ASDF_DIR"

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
$FISH -c 'set -Ux ASDF_CONFIG_FILE  "$HOME/.config/asdfrc"'

# Load ASDF
. "$ASDF_DIR/asdf.sh"

# Install Elixir Plugin
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git

# Install Elixir
asdf install elixir latest
asdf global elixir latest
