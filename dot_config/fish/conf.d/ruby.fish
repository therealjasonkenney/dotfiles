status is-interactive; and begin
  # ASDF will look for a file here and try installing gems when you install
  # ruby.
  set -gx ASDF_GEM_DEFAULT_PACKAGES_FILE "$HOME/.config/asdf/default-gems"

  # Set bundler files to use XDG based variables

  set -gx BUNDLE_USER_CACHE "$XDG_CACHE_HOME/bundle"
  set -gx BUNDLE_USER_CONFIG "$HOME/.config/bundle/config"
  set -gx BUNDLE_USER_HOME "$HOME/.local/share/bundle"

  # Setup ruby debugger.
  if type -q rbdg
    set -gx RUBY_DEBUG_OPEN true
    set -gx RUBY_DEBUG_HOST "127.0.0.1"
    set -gx RUBY_DEBUG_PORT 38698
  end
end
