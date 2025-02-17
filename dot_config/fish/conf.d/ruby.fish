status is-interactive; and begin
  # ASDF will look for a file here and try installing gems when you install
  # ruby.
  set -gx ASDF_GEM_DEFAULT_PACKAGES_FILE "$HOME/.config/asdf/default-gems"

  # Setup ruby debugger.
  if type -q rbdg
    set -gx RUBY_DEBUG_OPEN true
    set -gx RUBY_DEBUG_HOST "127.0.0.1"
    set -gx RUBY_DEBUG_PORT 38698
  end
end
