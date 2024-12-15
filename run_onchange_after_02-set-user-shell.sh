#!/bin/sh

set -e

OS=$(uname -s)

if [ "$OS" = "Darwin" ]; then
  SHELL_PATH=/opt/homebrew/bin/fish
else
  SHELL_PATH=/usr/local/bin/fish
fi

# Add fish to /etc/shells if its not there.
if [ -z "$(grep -F -- $SHELL_PATH /etc/shells)" ]; then
  echo "Adding $SHELL_PATH to /etc/shells"
  echo $SHELL_PATH | sudo tee -a /etc/shells > /dev/null
fi

# Change login shell to fish
echo "Setting shell to $SHELL_PATH"
chsh -s $SHELL_PATH
