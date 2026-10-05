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
- **Bat:** A simple code viewer for the terminal so I can see syntax-highlighted
  code without opening an editor.
- **Fish:** I use `fish` because it's scripting is easier than `bash`, it has
  completions, and is easy to have different configurations in one directory, so
  I can include/exclude easier than with
`zsh`. (It's also written in `rust`)
- **Neovim:** I prefer modal editing, `neovim` provides a vi-like experience,
  but with `lua` configuration, `lsp` support, but is more familiar than
  `vscode` would be.

### Security
I store my ssh keys on `yubikey`.

- **gpg:** Signs `git` commits, bridges the `yubikey` with `git` and `ssh`.
- **pinentry-mac:** Handles pin entry when using the yubikey with `git` and `ssh`
- **ykman:** Manage the yubikeys.

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

|                        |                |                                        |
| ---------------------- | -------------- | -------------------------------------- |
| **Archives**           | Keka           | [website](https://www.keka.io)         |
| **Video**              | VLC            | [website](https://www.videolan.org)    |

## Writing Environment

- **Scrivener:** I write scenes in a non-linear fashion and often need to then
  determine how they fit, often cutting and stiching in a similar way to
  analogue film editing. Scrivener stores each scene as an individual `rtf` file
  and keeps the metadata, and organization in `xml` files. It has versioning, notes,
  corkboards for researching and brainstorming. This is (IMHO) the best too for **me**
  when it comes to novels or complex academic papers.
  [link](https://www.literatureandlatte.com/scrivener/overview)
- **Antidote:** Spelling and Grammar, I use this because its a local application
  and its AI utilities can be ignored.
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
- **Phoenix Slides:** Bulk image viewer, see [website](https://blyt.net/phxslides/).
