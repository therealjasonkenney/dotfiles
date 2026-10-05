# dotfiles

My dotfiles repo used by chezmoi

## Installation

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply therealjasonkenney/dotfiles.git
```

## Development Environment

|                              |            |                                                  |
| ---------------------------- | ---------- | ------------------------------------------------ |
| **Find**                     | `fd`       | [website](https://github.com/sharkdp/fd)         |
|                              | `sk`       | [website](https://github.com/skim-rs/skim)       |
| **Editor**                   | `nvim`     | [website](https://neovim.io)                     |
| **Language Version Manager** | `asdf`     | [website](https://asdf-vm.com)                   |
| **Prompt**                   | `starship` | [website](https://starship.rs/)                  |
| **Search**                   | `rg`       | [website](https://github.com/burntsushi/ripgrep) |
| **Shell**                    | `fish`     | [website](https://fishshell.com/)                |
| **Package Manager**          | `brew`     | [website](https://brew.sh)                       |

- **ASDF:** I use `asdf` to handle installation and switching versions for: `elixir`, `node`, and `ruby`.
- **Bat:** A simple code viewer for the terminal so I can see syntax-highlighted code without opening an editor.
- **Fish:** I use `fish` because it's scripting is easier than `bash`, it has completions, and is easy to have different configurations in one directory, so I can include/exclude easier than with
`zsh`. (It's also written in `rust`)
- **Neovim:** I prefer modal editing, `neovim` provides a vi-like experience, but with `lua` configuration, `lsp` support, but is more familiar than `vscode` would be.


### Other programming language support.
- C/C++
- Python
- Rust
- Swift
- TeX/LaTeX

### Services
- Docker (via `colima`)
- Kubernetes
- Postgres (via Postgres.app)

## File Handlers

|                        |                |   |
| ---------------------- | -------------- | - |
| **Archives**           | Keka           | [https://www.keka.io](https://www.keka.io) |
| **Audio (MP3, CD)**    | Apple Music    | |
| **Image / PDF**        | Apple Preview  | |
|                        | Phoenix Slides | [https://blyt.net/phxslides/](https://blyt.net/phxslides/) |
| **Video**              | VLC ([https://www.videolan.org](https://www.videolan.org)) |

## Photography

- Apple Photos
- Affinity Photo 2

## Writing Environment

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

## Other Utilities
- **cdrao:** CD Archival tool
- **imagemagick:** Image conversion utilities.
