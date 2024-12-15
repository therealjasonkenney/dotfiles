#!/bin/sh
#
#

OS=$(uname -s)

case $OS in
  Darwin)
    export HOMEBREW_BUNDLE_FILE_GLOBAL="$HOME/.config/brewfile/Brewfile"

    eval "$(/opt/homebrew/bin/brew shellenv)"

    brew bundle install --cleanup --zap --global

    ;;
  *)
    xargs sudo apt-get -y install < "$HOME/.config/packages.txt"
    ;;
esac
