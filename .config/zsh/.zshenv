# .zshenv - sourced for EVERY zsh (interactive, scripts, cron, subshells).
#
# Belongs here: environment variables and PATH that scripts also need.
# Does not belong here: aliases, functions, options, prompt, completion,
# anything that prints (breaks scp/rsync), anything slow (no subprocesses).

# XDG Base Directory Specification
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export DOTFILES_HOME="$HOME/.dotfiles"

# Locale
export LANG=en_US.UTF-8
export LC_TIME=en_IE.UTF-8

# Default programs
export BROWSER="$HOME/.local/bin/linkhandler"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="bat --paging=always"

# Keep path arrays free of duplicates. Prepending an existing entry moves it
# to the front, which is what lets .zprofile restore our ordering after
# macOS path_helper rearranges PATH.
typeset -U path fpath manpath

# Untracked machine-local secrets and environment (internal values that must
# not land in the public dotfiles repo)
[[ -r "$ZDOTDIR/local/secrets.zsh" ]] && source "$ZDOTDIR/local/secrets.zsh"
[[ -r "$ZDOTDIR/local/env.zsh" ]] && source "$ZDOTDIR/local/env.zsh"

# Platform environment. $OSTYPE is built in; $(uname) would fork per shell.
if [[ $OSTYPE == darwin* ]]; then
    source "$ZDOTDIR/env/darwin.zsh"
else
    source "$ZDOTDIR/env/linux.zsh"
fi

# User binaries take precedence over everything above. mise shims replace
# `mise activate`: no per-prompt hook, and scripts/cron see the same tools.
path=(
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$XDG_DATA_HOME/mise/shims"
    $path
)
export PATH

# Snapshot for .zprofile (shell variable, not exported).
_zshenv_path=($path)
