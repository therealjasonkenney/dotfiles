#!/usr/bin/env sh

ASDF_DIR="$HOME/.local/share/asdf"

rm -rf "$ASDF_DIR"
git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR" --branch v0.14.1
