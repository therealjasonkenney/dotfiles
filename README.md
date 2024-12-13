# dotfiles

My dotfiles repo used by chezmoi

## Installation

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply therealjasonkenney/dotfiles.git
```

### File Handlers

| | |
| - | - |
| **Archives** | Stuffit Expander |
| **Audio (MP3, CD)** | Apple Music |
| **Image / PDF** | Apple Preview |
| **Source Code / Text** | Neovide ([doc](http://neovide.dev/)) |
| **Video** | VLC ([doc](https://www.videolan.org)) |

### Photography

- **Apple Photos:** TBD
- **Affinity Photo 2:** TBD

### Writing Environment

- **Scrivener:** I write scenes in a non-linear fashion and often need to then
  determine how they fit, often cutting and stiching in a similar way to
  analogue film editing. Scrivener stores each scene as an individual `rtf` file
  and keeps the metadata, and organization in `xml` files. It has versioning, notes,
  corkboards for researching and brainstorming. This is (IMHO) the best too for **me**
  when it comes to novels or complex academic papers.
  [link](https://www.literatureandlatte.com/scrivener/overview)
- **Endnote:** Citations and managing references is a pain to do in a spreadsheet.
  Its not perfect and requires some tweaking, but when you have 10-20 sources you are
  assembling and need to cite correctly, a reference manager helps with that, I like
  endnote and it works with both scrivener and word fairly well, but there are
  plenty of options.
- **Microsoft Word:** Many magazines and agents still require submissions to be `docx` in
  manuscript format. Scrivener can compile to ms word. This is also useful when getting
  feedback from those who use the review features.

### Computing Environment

- **fish:** My shell.
- **neovim:** I prefer modal editing, neovim provides a vi-like experience,
  but with lua configuration, lsp support, but is more familiar than vscode would be.
- **bat:** A simple code viewer for the terminal so I can see syntax-highlighted code without
  opening an editor.
- **ripgrep:** Lets me search a project for specific instances of code.
- **skim:** Fuzzy file finding.
- **Wezterm:** A terminal emulator that supports proper copy/paste with neovim, tabs, and
  the full terminal codes (which OSX Terminal does not), that isn't an electron app.
