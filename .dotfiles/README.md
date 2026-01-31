# dotfiles

My UNIX dotfiles, managed via the bare git repository method. Primarily used on Arch Linux, Fedora, and macOS.

## Installation

```sh
curl -Lks https://raw.githubusercontent.com/waifod/dotfiles/main/.dotfiles/bootstrap.sh | sh
```

Or follow [this guide](https://www.atlassian.com/git/tutorials/dotfiles) for manual setup.

After installation, use `cfg` as an alias for git operations on your dotfiles:
```sh
cfg status
cfg add .config/some/file
cfg commit -m "update config"
cfg push
```

## Dependencies

Install these for the full config to work. The config gracefully handles missing tools, but functionality will be limited.

### Required

| Tool | Purpose | Install |
|------|---------|---------|
| [zsh](https://github.com/zsh-users/zsh) | shell | `pacman -S zsh` / comes with macOS |
| [git](https://git-scm.com/) | version control | `pacman -S git` / `brew install git` |
| [neovim](https://github.com/neovim/neovim) | editor | `pacman -S neovim` / `brew install neovim` |

### Shell & terminal

| Tool | Purpose | Install |
|------|---------|---------|
| [sheldon](https://github.com/rossmacarthur/sheldon) | zsh plugin manager | `pacman -S sheldon` / `brew install sheldon` |
| [alacritty](https://github.com/alacritty/alacritty) | terminal | `pacman -S alacritty` / `brew install --cask alacritty` |
| [tmux](https://github.com/tmux/tmux) | terminal multiplexer | `pacman -S tmux` / `brew install tmux` |

### CLI replacements (aliased)

| Tool | Replaces | Install |
|------|----------|---------|
| [bat](https://github.com/sharkdp/bat) | cat, less | `pacman -S bat` / `brew install bat` |
| [eza](https://github.com/eza-community/eza) | ls | `pacman -S eza` / `brew install eza` |
| [fd](https://github.com/sharkdp/fd) | find | `pacman -S fd` / `brew install fd` |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | grep | `pacman -S ripgrep` / `brew install ripgrep` |
| [dust](https://github.com/bootandy/dust) | du | `pacman -S dust` / `brew install dust` |
| [bottom](https://github.com/ClementTsang/bottom) | top/htop | `pacman -S bottom` / `brew install bottom` |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | cd | `pacman -S zoxide` / `brew install zoxide` |
| [delta](https://github.com/dandavison/delta) | git pager | `pacman -S git-delta` / `brew install git-delta` |
| [fzf](https://github.com/junegunn/fzf) | fuzzy finder | `pacman -S fzf` / `brew install fzf` |

### Development

| Tool | Purpose | Install |
|------|---------|---------|
| [mise](https://github.com/jdx/mise) | runtime version manager | `pacman -S mise` / `brew install mise` |
| [uv](https://github.com/astral-sh/uv) | Python package manager | `pacman -S uv` / `brew install uv` |

### Optional

| Tool | Purpose | Install |
|------|---------|---------|
| [syncthing](https://syncthing.net/) | file sync | `pacman -S syncthing` / `brew install syncthing` |
| [unison](https://github.com/bcpierce00/unison) | bidirectional sync | `pacman -S unison` / `brew install unison` |
| [newsboat](https://newsboat.org/) | RSS reader | `pacman -S newsboat` / `brew install newsboat` |
| [keychain](https://www.funtoo.org/Funtoo:Keychain) | SSH key management | `pacman -S keychain` / `brew install keychain` |
| [gammastep](https://gitlab.com/chinstrap/gammastep) | screen color temp | `pacman -S gammastep` / (Linux only) |

### Quick install (Arch)

```sh
pacman -S zsh git neovim sheldon alacritty tmux bat eza fd ripgrep dust bottom zoxide git-delta fzf mise uv
```

### Quick install (Fedora)

```sh
dnf install zsh git neovim alacritty tmux bat eza fd-find ripgrep dust bottom zoxide git-delta fzf uv
```

Note: `sheldon` and `mise` aren't in Fedora repos. Install via:
```sh
curl https://mise.run | sh
cargo install sheldon  # or download from GitHub releases
```

### Quick install (macOS)

```sh
brew install zsh git neovim sheldon tmux bat eza fd ripgrep dust bottom zoxide git-delta fzf mise uv
brew install --cask alacritty
```

## Shell

**zsh** with [sheldon](https://github.com/rossmacarthur/sheldon) as the plugin manager.

Plugins:
- [fzf-tab](https://github.com/Aloxaf/fzf-tab) - fuzzy completion

`~/.zshenv` sets `ZDOTDIR` to `~/.config/zsh/`, keeping the home directory clean. The config is modular:
- `.zshrc` - main entry point
- `.zsh_aliases` - command aliases
- `.zsh_functions` - shell functions
- `.zsh_tools` - tool integrations (mise, uv)
- `.zsh_darwin` / `.zsh_linux` - OS-specific settings
- `.zsh_prompt` - prompt configuration

## Terminal

- [alacritty](https://github.com/alacritty/alacritty) - GPU-accelerated terminal (gruvbox theme)
- [tmux](https://github.com/tmux/tmux) - terminal multiplexer with vim-style navigation

tmux plugins (via TPM):
- tmux-sensible, tmux-yank
- vim-tmux-navigator
- tmux-resurrect, tmux-continuum (session persistence)
- tmux-gruvbox (theme)

## Editor

[neovim](https://github.com/neovim/neovim) with [LazyVim](https://github.com/LazyVim/LazyVim) as the base config.

Notable additions:
- hardtime.nvim (learn vim motions)
- auto-session (session management)
- Language support: C/C++, Python, Rust, TypeScript

## Git

Notable settings:
- delta as pager with side-by-side diffs (gruvbox theme)
- histogram diff algorithm
- zdiff3 merge conflict style
- auto-stash on rebase
- fsmonitor enabled

## Directory structure

```
~/
├── .zshenv              # env vars, sources ZDOTDIR
└── .config/
    ├── alacritty/           # terminal config
    ├── bat/                 # bat config
    ├── bottom/              # system monitor
    ├── eza/                 # ls replacement theme
    ├── fontconfig/          # font settings
    ├── gammastep/           # screen color temp (Linux)
    ├── git/                 # git config
    ├── mise/                # runtime version manager
    ├── newsboat/            # RSS reader
    ├── nvim/                # neovim (LazyVim)
    ├── nyaa/                # torrent search
    ├── sheldon/             # zsh plugin manager
    ├── sway/                # Wayland compositor (Linux)
    ├── tmux/                # tmux config
    ├── transmission-daemon/ # torrent client
    ├── unison/              # file sync profiles
    └── zsh/                 # shell config

~/.local/bin/            # custom scripts
~/.dotfiles/             # bare git repo
```
