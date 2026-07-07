
fish_add_path -g {$HOME}/.local/cargo/bin

type -q cargo; and begin
  set -gx CARGO_HOME {$HOME}/.local/cargo
end

type -q rustup; and begin
  # Set location of cargo and rustup to adhere to XDG guidelines.
  set -gx RUSTUP_HOME {$HOME}/.local/rustup

  # Tell rustup to use rust stable (as opposed to nightly or a pinned version).
  set -gx RUST_TOOLCHAIN 'stable'
end
