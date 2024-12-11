# Brewfile for distraction free writing.
# MacOS build version: {{ output "sw_vers" "--buildVersion" }}

cask_args(no_quarantine: true, require_sha: true)

# CLI source code viewer
brew("bat")
# Dependency for ASDF
brew("coreutils")
# Dependency for ASDF (grabs remote content)
brew("curl")
# find replacement.
brew("fd")
# Version Control
brew("git")
# LFS Support
brew("git-lfs")
# Image transformation/conversion tools.
brew("imagemagick")
# Mac App Store.
brew("mas")
# CLI Text Editor
brew("neovim")
# CLI Text Search
brew("ripgrep")
# Fuzzy finder (used in neovim's fzf plugin)
brew("sk")
# Font used for Terminal and NeoVim
cask("font-hack")
# Font used for Boardgames
cask("font-charis-sil")
# NeoVim GUI frontend.
cask("neovide")
# Terminal Emulator
cask("wezterm")
# BBedit Text Editor, requires License.
cask("bbedit")
# Used for RPGs
cask("discord")
# Reference Manager, requires License.
cask("endnote", args: {require_sha: false})
# Mozilla Firefox Web Browser.
cask("firefox")
# Novel writing software, requires license.
cask("scrivener")
# Video Player.
cask("vlc")
# Harvard and Therapist use this.
cask("zoom")

mas("Affinity Publisher 2", id: 1606941598)
mas("CARROT Weather", id: 993487541)
mas("Microsoft Excel", id: 586683407)
mas("Microsoft OneDrive", id: 477537958)
mas("Microsoft Word", id: 586447913)
mas("Omnigraffle 7", id: 1142578753)
mas("Remarkable Desktop", id: 1276493162)
mas("Stuffit Expander", id: 919269455)
