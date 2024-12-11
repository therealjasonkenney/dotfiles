#!/usr/local/bin/fish
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

# ###################### ENVIRONMENT #######################################
set -l asdf_cfg "$HOME/.config/asdf"
set -l os (uname)

set -Ux ASDF_DIR         "$HOME/.local/share/asdf"
set -Ux ASDF_DATA_DIR    "$ASDF_DIR"
set -Ux ASDF_CONFIG_FILE "$asdf_cfg/asdfrc"

set -Ux ASDF_GEM_DEFAULT_PACKAGES_FILE    "$asdf_cfg/default-gems"
set -Ux ASDF_GOLANG_DEFAULT_PACKAGES_FILE "$asdf_cfg/default-golang-pkgs"
set -Ux ASDF_NPM_DEFAULT_PACKAGES_FILE    "$asdf_cfg/default-npm-packages"
set -Ux ASDF_PYTHON_DEFAULT_PACKAGES_FILE "$asdf_cfg/default-python-packages"

set -Ux EDITOR               nvim
set -Ux SKIM_DEFAULT_COMMAND "fd --type f || git ls-tree -r --name-only HEAD || rg --files"
set -Ux STARSHIP_CONFIG      {$HOME}/.config/starship.toml
set -Ux ZELLIJ_CONFIG_DIR    {$HOME}/.config/zellij

if test $os = Darwin
  set -Ux XDG_CACHE_HOME "$HOME/Library/Caches"
end

# ############################################################################
