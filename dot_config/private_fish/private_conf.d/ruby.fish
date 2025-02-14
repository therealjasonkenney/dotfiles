
# Setup ruby debugger.
status is-interactive; and begin
  set -gx RUBY_DEBUG_OPEN true
  set -gx RUBY_DEBUG_HOST "127.0.0.1"
  set -gx RUBY_DEBUG_PORT 38698
end
