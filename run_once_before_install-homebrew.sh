#!/bin/sh
#
#

set -e

OS=`uname -s`

# Homebrew is the package manager for MacOS.
# So Linux/Windows need not apply here.
if [ "$OS" = "Darwin" ] ; then
  # Uninstall
  if [ -d /opt/homebrew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

    echo "Need root privileges to remove /opt/homebrew"
    sudo rm -rf /opt/homebrew
  fi

  # Install
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add to the PATH
  # echo "Need root privileges to add homebrew to launchctl services path"
  # sudo launchctl config user path "$(/opt/homebrew/bin/brew --prefix)/bin:/usr/bin:/bin:/usr/sbin:/sbin"
fi
