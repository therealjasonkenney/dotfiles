#!/usr/bin/env fish
#
#

# Fish ignores paths that do not exist, so we can add these without
# issue.
fish_add_path /bin
fish_add_path /sbin
fish_add_path /usr/bin
fish_add_path /usr/sbin
fish_add_path /usr/local/bin
fish_add_path /usr/local/sbin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path "$HOME/Applications/Postgres.app/Contents/Versions/latest/bin"

begin
  set -l fish_path $(command -v fish)

  # Add fish to /etc/shells if its not there.
  if test -z "$(grep -F -- $fish_path /etc/shells)"
    echo "Adding $fish_path to /etc/shells"
    echo $fish_path | sudo tee -a /etc/shells > /dev/null
  end

  # Change login shell to fish
  chsh -s $fish_path
end

# #### ENVIRONMENT #############################################

set -Ux EDITOR 'nvim'
set -Ux LANG   'en'
set -Ux LC_ALL 'enUS.UTF-8'

set -Ux SKIM_DEFAULT_COMMAND "fd --type f || git ls-tree -r --name-only HEAD || rg --files"

# ##############################################################

# #### CONFIGURATION DIRECTORIES ###############################
# Try to have everything in XDG locations for consistency.

set -l asdf_cfg "$HOME/.config/asdf"

set -Ux ASDF_DIR          "$HOME/.local/share/asdf"
set -Ux ASDF_DATA_DIR     "$ASDF_DIR"
set -Ux ASDF_CONFIG_FILE  "$asdf_cfg/asdfrc"
set -Ux GNUPGHOME         "$HOME/.local/share/gnupg"
set -Ux STARSHIP_CONFIG   "$HOME/.config/starship.toml"
set -Ux ZELLIJ_CONFIG_DIR "$HOME/.config/zellij"

set -Ux ASDF_GEM_DEFAULT_PACKAGES_FILE    "$asdf_cfg/default-gems"
set -Ux ASDF_GOLANG_DEFAULT_PACKAGES_FILE "$asdf_cfg/default-golang-pkgs"
set -Ux ASDF_NPM_DEFAULT_PACKAGES_FILE    "$asdf_cfg/default-npm-packages"
set -Ux ASDF_PYTHON_DEFAULT_PACKAGES_FILE "$asdf_cfg/default-python-packages"
# ##############################################################

# #### MAC SPECIFIC TWEAKS #####################################
set -l os (uname)
if test $os = Darwin
  set -Ux HOMEBREW_BUNDLE_FILE_GLOBAL "$HOME/.config/brewfile/Brewfile"
  set -Ux XDG_CACHE_HOME              "$HOME/Library/Caches"
end

# ##############################################################

