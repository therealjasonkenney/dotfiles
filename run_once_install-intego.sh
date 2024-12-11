#!/usr/bin/env sh
#
#

OS="$(uname -s)"
IMG="./src/Mac_Internet_Security_X9.dmg"

if [ "$OS" = "Darwin" ]; then
  hdiutil attach "$IMG"
  open -W "/Volumes/Mac Internet Security X9/Intego Installer.app"
fi
