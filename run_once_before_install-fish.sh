#!/usr/bin/env sh
#
#

set -eo pipefail

OS=`uname -s`
FISH='/usr/local/bin/fish'

# Using the pakage version so we ensure fish is always in /usr/local/bin/fish
if [ "$OS" = "Darwin" ] ; then
  echo "Need permission to install fish."
  sudo installer -pkg "./src/fish-3.7.1.pkg" -target /
fi

# Add fish to /etc/shells
if [ -z "$(grep -F -- $FISH /etc/shells)" ]; then
  echo "Adding $FISH to /etc/shells"
  sudo echo "$FISH" >> /etc/shells
fi

# Change login shell to fish
chsh -s $FISH
