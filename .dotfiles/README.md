# dotfiles

My UNIX dotfiles, managed via the [bare git repository method](https://www.atlassian.com/git/tutorials/dotfiles). Primarily used on Arch Linux (desktop), Fedora (headless VPS), and macOS.

## Installation

```sh
curl -L https://github.com/waifod/dotfiles/archive/main.tar.gz | tar xz -C /tmp
/tmp/dotfiles-main/.dotfiles/bootstrap/bootstrap.sh
```

This will:
1. Install OS packages (core tools, CLI replacements, media, fonts)
2. Set up Rust toolchain and cargo-update
3. Clone dotfiles as a bare repo to `~/.dotfiles`
4. Checkout config files (backing up conflicts to `~/.config-backup/`)
5. Install TPM, sheldon plugins, and neovim plugins
6. Change default shell to zsh

Log out and back in after installation for the shell change to take effect.

After installation, use `cfg` as an alias for git operations on your dotfiles:
```sh
cfg status
cfg add .config/some/file
cfg commit -m "update config"
cfg push
```

## Updating

Run `sysup` to update everything:
- System packages (pacman/paru, dnf, or brew)
- Rust toolchain and cargo packages
- uv tools, mise runtimes
- Sheldon, neovim, and tmux plugins

## Syncthing setup

After bootstrap, configure syncthing to sync folders between devices. See the [getting started guide](https://docs.syncthing.net/intro/getting-started.html) for details.

1. Open the web UI at http://localhost:8384
   - For remote servers: `ssh -L 8384:localhost:8384 <host>`, then open http://localhost:8384
2. Get your device ID: Actions → Show ID
3. On each device, add remote devices: Add Remote Device → paste their ID
4. Accept the device on the other side
5. Share folders: Add Folder → set path to `~/sync` → select devices to share with

Config is stored in `~/.config/syncthing/`.

## Fedora VPS setup

The Fedora bootstrap includes security hardening:
- SSH: root login and password auth disabled
- firewalld: SSH (22), syncthing (22000/tcp, 21027/udp)
- fail2ban: brute force protection
- dnf5-automatic: daily security updates

For defense in depth, configure Hetzner Cloud Firewall with matching rules:
- Inbound TCP 22 (SSH)
- Inbound TCP 22000 (syncthing)
- Inbound UDP 21027 (syncthing discovery)

## Dependencies

| Category | Packages | Arch | Fedora | macOS |
|----------|----------|:----:|:------:|:-----:|
| Core | git, zsh, tmux, neovim | ✓ | ✓ | ✓ |
| Core | alacritty | ✓ | | ✓ |
| Core | zsh-completions | ✓ | | |
| Dev | rustup, mise, uv, sheldon | ✓ | ✓ | ✓ |
| Dev | clang | ✓ | ✓ | ✓ |
| Dev | google-benchmark | ✓ | ✓ | ✓ |
| Dev | perf | ✓ | ✓ | |
| CLI | bat, eza, fd, ripgrep, dust, bottom, zoxide, git-delta, fzf | ✓ | ✓ | ✓ |
| Git | git-lfs | ✓ | ✓ | ✓ |
| Sync | unison, syncthing | ✓ | ✓ | ✓ |
| Media | wget | ✓ | ✓ | ✓ |
| Media | mpv, yt-dlp | ✓ | | ✓ |
| Apps | newsboat, Proton Pass | ✓ | | ✓ |
| Apps | Firefox, Chrome | ✓ | | (manual) |
| Apps | transmission-cli, tremc, nyaa | ✓ | | |
| Desktop | sway, gammastep, bemenu, swaylock, swayidle, grim, mako, ddcutil | ✓ | | |
| Audio | pipewire, pipewire-pulse, pamixer | ✓ | | |
| Fonts | JetBrains Mono Nerd, Noto | ✓ | | ✓ |
| Security | firewalld, fail2ban | | ✓ | |

## Tools

### Dev

| Tool | Purpose |
|------|---------|
| [clang](https://clang.llvm.org/) | C/C++ compiler and tooling |
| [google-benchmark](https://github.com/google/benchmark) | microbenchmark library |
| [perf](https://perf.wiki.kernel.org/) | Linux profiling (Arch/Fedora only) |
| [rustup](https://github.com/rust-lang/rustup) | Rust toolchain manager |
| [mise](https://github.com/jdx/mise) | polyglot runtime manager (node, python, etc.) |
| [uv](https://github.com/astral-sh/uv) | fast Python package/project manager |
| [sheldon](https://github.com/rossmacarthur/sheldon) | zsh plugin manager |

### CLI replacements

Aliased in shell config:

| Tool | Replacement |
|------|-------------|
| cat, less | [bat](https://github.com/sharkdp/bat) |
| ls | [eza](https://github.com/eza-community/eza) |
| find | [fd](https://github.com/sharkdp/fd) |
| grep | [ripgrep](https://github.com/BurntSushi/ripgrep) |
| du | [dust](https://github.com/bootandy/dust) |
| top/htop | [bottom](https://github.com/ClementTsang/bottom) |
| cd | [zoxide](https://github.com/ajeetdsouza/zoxide) |
| git pager | [delta](https://github.com/dandavison/delta) |
| fuzzy finder | [fzf](https://github.com/junegunn/fzf) |

### Media and apps

| Tool | Purpose |
|------|---------|
| [syncthing](https://github.com/syncthing/syncthing) | continuous file sync |
| [mpv](https://github.com/mpv-player/mpv) | video player |
| [yt-dlp](https://github.com/yt-dlp/yt-dlp) | video downloader |
| [newsboat](https://github.com/newsboat/newsboat) | RSS reader |
| [transmission-cli](https://github.com/transmission/transmission) | torrent daemon |
| [tremc](https://github.com/tremc/tremc) | transmission curses client |
| [nyaa](https://github.com/Beastwick18/nyaa) | torrent search TUI |
| [Proton Pass](https://proton.me/pass) | password manager |
| [Firefox](https://www.mozilla.org/firefox/) | browser |
| [Chrome](https://www.google.com/chrome/) | browser |

### Desktop (Arch)

| Tool | Purpose |
|------|---------|
| [sway](https://github.com/swaywm/sway) | Wayland compositor |
| [gammastep](https://gitlab.com/chinstrap/gammastep) | screen color temperature |
| [bemenu](https://github.com/Cloudef/bemenu) | launcher |
| [swaylock](https://github.com/swaywm/swaylock) | screen locker |
| [swayidle](https://github.com/swaywm/swayidle) | idle manager |
| [grim](https://github.com/emersion/grim) | screenshot tool |
| [mako](https://github.com/emersion/mako) | notifications |

## Configuration

### Shell

[zsh](https://www.zsh.org/) with [sheldon](https://github.com/rossmacarthur/sheldon) as the plugin manager.

Plugins:
- [fzf-tab](https://github.com/Aloxaf/fzf-tab) - fuzzy completion

`~/.zshenv` sets `ZDOTDIR` to `~/.config/zsh/`, keeping the home directory clean. The config is modular:
- `.zshenv_darwin` / `.zshenv_linux` - OS-specific env vars (PATH, etc.)
- `.zshrc` - main entry point
- `.zsh_options` - shell options
- `.zsh_history` - history settings
- `.zsh_aliases` - command aliases
- `.zsh_functions` - shell functions
- `.zsh_tools` - tool integrations (mise, uv)
- `.zsh_prompt` - prompt configuration
- `.zsh_darwin` / `.zsh_linux` - OS-specific interactive settings

### Terminal

- [alacritty](https://github.com/alacritty/alacritty) - GPU-accelerated terminal (gruvbox theme)
- [tmux](https://github.com/tmux/tmux) - terminal multiplexer with vim-style navigation

tmux plugins (via [TPM](https://github.com/tmux-plugins/tpm)):
- [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible), [tmux-yank](https://github.com/tmux-plugins/tmux-yank)
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
- [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect), [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) (session persistence)
- [tmux-gruvbox](https://github.com/egel/tmux-gruvbox) (theme)

### Editor

[neovim](https://github.com/neovim/neovim) with [LazyVim](https://github.com/LazyVim/LazyVim) as the base config.

Notable additions:
- [hardtime.nvim](https://github.com/m4xshen/hardtime.nvim) (learn vim motions)
- [auto-session](https://github.com/rmagatti/auto-session) (session management)
- Language support: C/C++, Python, Rust, TypeScript

### Git

Notable settings:
- delta as pager with side-by-side diffs (gruvbox theme)
- histogram diff algorithm
- zdiff3 merge conflict style
- auto-stash on rebase
- fsmonitor enabled

## Directory structure

```
~/
├── .zshenv              # env vars, sets ZDOTDIR
├── .config/
│   ├── alacritty/           # terminal config
│   ├── bat/                 # bat config
│   ├── bottom/              # system monitor
│   ├── eza/                 # ls replacement theme
│   ├── fontconfig/          # font settings
│   ├── gammastep/           # screen color temp (Linux)
│   ├── git/                 # git config
│   ├── mise/                # runtime version manager
│   ├── newsboat/            # RSS reader
│   ├── nvim/                # neovim (LazyVim)
│   ├── nyaa/                # torrent search
│   ├── sheldon/             # zsh plugin manager
│   ├── sway/                # Wayland compositor (Linux)
│   ├── tmux/                # tmux config
│   ├── transmission-daemon/ # torrent client
│   ├── unison/              # file sync profiles
│   └── zsh/                 # shell config
├── .local/bin/          # custom scripts (sysup, etc.)
└── .dotfiles/
    ├── bootstrap/       # OS-specific install scripts
    └── (bare git repo)
```
