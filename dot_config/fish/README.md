# Fish Configuration
Fish is my userland shell

## PATH
`PATH` is setup to give access to programming environment
binaries and the paths for installed tools (such as homebrew)
as well as not muck with Apple's PATH configuration.

This is configured by:
* Default Path setup via `/usr/libexec/path_helper` and `/etc/paths.d`.
* ASDF: `$HOME/.local/share/asdf/asdf.fish`
* Fish: `$HOME/.config/fish/config.fish`

### Paths
* Programming language binaries: 
  - **Rust:** `$HOME/.local/cargo/bin`
  - **ASDF** (Elixir/Node/Ruby): `$HOME/.local/share/asdf/shims`

* Tools
  - **ASDF:** `$HOME/.local/share/asdf/bin`
  - **Postgres:** `/Applications/Postgres.app/Contents/Versions/latest/bin`
  - **Homebrew Packages:** `/opt/homebrew/bin`
  - **Tex:** `/Libary/TeX/textbin`

* Apple's Security (They add this to the default path) you can find all this in `/etc/paths.d`
  - `/System/Cryptexes/App/usr/bin`
  - `/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin`
  - `/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin`
  - `/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin`

* Default POSIX paths
  - `/usr/local/bin`
  - `/usr/bin`
  - `/bin`
  - `/usr/sbin`
  - `/sbin`

## Shell environment
* Set my Locale to US English (UTF-8), `LANG` and `LC_ALL` are used in many CLI applications.
* Use `bat` as my man pager.
* Use `starship` to set my prompt.

### Prompt
* username 
* local time (24hr)
* git status 
* path (last two directories)

## Programming Environment

* Load ASDF and its shims if its installed.
* Set `RUST_TOOLCHAIN` to `stable`
* Set `EDITOR` to Neovim.

## Cache configuration
I set `XDG_CACHE_HOME` and `STARSHIP_CACHE` to use `$HOME/Library/Caches` on
MacOS to leverage the OS' handling of cache files.

## Config locations.
Where possible I set my configuration to use `$HOME/.config` as
per XDG guidelines. This requires some tools such as ASDF and ZELLIJ to
be explicitly set.

## Security
GPG is configured to be used by SSH and setup to allow yubikey
authentication.
