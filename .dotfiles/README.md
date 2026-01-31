# dotfiles

My UNIX dotfiles, managed via the bare git repository method. Primarily used on Arch Linux and macOS.

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

## Shell

**zsh** with [sheldon](https://github.com/rossmacarthur/sheldon) as the plugin manager.

Plugins:
- [fzf-tab](https://github.com/Aloxaf/fzf-tab) - fuzzy completion

The zsh config is modular, split across `~/.config/zsh/`:
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

## CLI Replacements

| Standard | Replacement | Notes |
|----------|-------------|-------|
| `cat` | [bat](https://github.com/sharkdp/bat) | syntax highlighting |
| `ls` | [eza](https://github.com/eza-community/eza) | modern ls |
| `find` | [fd](https://github.com/sharkdp/fd) | faster, simpler syntax |
| `grep` | [ripgrep](https://github.com/BurntSushi/ripgrep) | faster, respects .gitignore |
| `du` | [dust](https://github.com/bootandy/dust) | intuitive disk usage |
| `less` | bat | pager with syntax highlighting |
| `top` | [bottom](https://github.com/ClementTsang/bottom) | system monitor |
| `cd` | [zoxide](https://github.com/ajeetdsouza/zoxide) | smarter directory jumping |

## Git

Uses [delta](https://github.com/dandavison/delta) as the pager with side-by-side diffs and gruvbox syntax theme.

Notable settings:
- histogram diff algorithm
- zdiff3 merge conflict style
- auto-stash on rebase
- fsmonitor enabled

## Other Tools

- [mise](https://github.com/jdx/mise) - runtime version manager (node, python, etc.)
- [uv](https://github.com/astral-sh/uv) - fast Python package manager
- [fzf](https://github.com/junegunn/fzf) - fuzzy finder
- [syncthing](https://syncthing.net/) - file synchronization
- [unison](https://github.com/bcpierce00/unison) - bidirectional file sync
- [newsboat](https://newsboat.org/) - RSS reader
- keychain - SSH key management

## Directory Structure

```
~/.config/
├── alacritty/     # terminal config
├── bat/           # bat config
├── bottom/        # system monitor
├── eza/           # ls replacement theme
├── git/           # git config
├── nvim/          # neovim (LazyVim)
├── sheldon/       # zsh plugin manager
├── tmux/          # tmux config
└── zsh/           # shell config

~/.local/bin/      # custom scripts
~/.dotfiles/       # bare git repo
```
