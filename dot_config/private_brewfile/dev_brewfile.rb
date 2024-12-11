# Common formula for setting up a dev environment work and home.

# CLI source code viewer
brew("bat")
# LSP for HTML/CSS/JS
brew("biome")
# Dependency for ASDF
brew("coreutils")
# Dependency for ASDF (grabs remote content)
brew("curl")
# find replacement.
brew("fd")
# Version Control
brew("git")
# Image transformation/conversion tools.
brew("imagemagick")
# CLI Text Editor
brew("neovim")
# CLI Text Search
brew("ripgrep")
# Fuzzy finder (used in neovim's fzf plugin)
brew("sk")
# Terminal Muxer
brew("zellij")

# Mozilla Firefox Web Browser.
cask("firefox")
# Font used for Terminal and NeoVim
cask("font-hack")
# NeoVim GUI frontend.
cask("neovide")
# Terminal Emulator
cask("wezterm")
