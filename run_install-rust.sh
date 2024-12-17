#!/bin/sh
#
#

OS=$(uname -s)

export CARGO_HOME="$HOME/.local/cargo"
export RUSTUP_HOME="$HOME/.local/rustup"
export RUST_TOOLCHAIN=stable

if [ ! -d "$RUSTUP_HOME" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if [ $OS = Darwin ] ; then
  PATH="/opt/homebrew/bin:$PATH"
fi

# Configure fish so it knows where all the rust stuff is.
fish -c "set -Ux CARGO_HOME '$CARGO_HOME'"
fish -c "set -Ux RUSTUP_HOME '$RUSTUP_HOME'"

"$HOME/.local/cargo/bin/rustup" update
