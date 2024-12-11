set -q __fish_config_sourced; and exit

if test -e {$ASDF_DIR}/asdf.fish
  source {$ASDF_DIR}/asdf.fish
end
