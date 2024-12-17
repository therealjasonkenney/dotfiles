# ASDF manages the environments of several
# programming languages including ruby and elixir.

# Load ASDF if it exists.
# This modifies PATH so its best to run this
# for both login and interactive.
if test -e {$ASDF_DIR}/asdf.fish
  source {$ASDF_DIR}/asdf.fish
end
