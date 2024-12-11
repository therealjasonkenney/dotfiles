# This is the brewfile for my home development machines.
# MacOS build version: {{ output "sw_vers" "--buildVersion" }}

cask_args(require_sha: true, no_quarantine: true)

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
# OTP (Elixir Dependency)
brew("erlang@27")
# Video Transcoding
brew("ffmpeg")
# Version Control
brew("git")
# LFS support
brew("git-lfs")
# Ruby Dependency
brew("gmp")
# Image transformation/conversion tools.
brew("imagemagick")
# Ruby Dependency
brew("libyaml")
# Mac App Store.
brew("mas")
# CLI Text Editor
brew("neovim")
# CPU Emulator
brew("qemu")
# CLI Text Search
brew("ripgrep")
# Allows one to install rust.
brew("rustup")
# Sass Compiler
brew("sass/sass/sass")
# Fuzzy finder (used in neovim's fzf plugin)
brew("sk")
# Terminal Muxer
brew("zellij")

# TeX Utilities (Typesetting lanaguage)
cask("basictex")
# 3D Modeling software.
cask("blender")
# Used for RPGs
cask("discord")
# Reference Manager, requires License.
cask("endnote", args: {require_sha: false})
# Mozilla Firefox Web Browser.
cask("firefox")
# Font used for Terminal and NeoVim
cask("font-hack")
# Font used for Boardgames
cask("font-charis-sil")
# GODOT Game Engine
cask("godot")
# Video Transcoder (more userfriendly than ffmpeg)
cask("handbrake")
# NeoVim GUI frontend.
cask("neovide")
# Parallels Desktop, requires license.
cask("parallels")
# Postgres.app
cask("postgres-unofficial")
# Raspberry PI Imager Tool
cask("raspberry-pi-imager")
# Ren'Py Visual Novel Engine
cask("renpy")
# Novel writing software, requires license.
cask("scrivener")
# Video Games
cask("steam")
# Video Player.
cask("vlc")
# Terminal Emulator
cask("wezterm")
# Harvard and Therapist use this.
cask("zoom")

mas("Affinity Designer 2", id: 1616831348)
mas("Affinity Photo 2", id: 1616822987)
mas("Affinity Publisher 2", id: 1606941598)
mas("CARROT Weather", id: 993487541)
mas("Corel Painter Essentials", id: 1475152238)
mas("Microsoft Excel", id: 586683407)
mas("Microsoft OneDrive", id: 477537958)
mas("Microsoft Word", id: 586447913)
mas("Omnigraffle 7", id: 1142578753)
mas("Postico 2", id: 6446933691)
mas("Remarkable Desktop", id: 1276493162)
mas("Stuffit Expander", id: 919269455)
