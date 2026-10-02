#!/bin/sh

# .zshenv - Always sourced for ALL shells (interactive + non-interactive)
#
# This file is read first and for every shell invocation, including:
# - Interactive shells (your terminal)
# - Non-interactive shells (scripts, cron jobs)
# - Login shells
# - Subshells
#
# WHAT BELONGS HERE:
# - Environment variables needed by ALL shells (EDITOR, PAGER, LANG, etc.)
# - PATH modifications (so scripts and cron jobs can find your tools)
# - XDG Base Directory variables
# - Variables that other programs might need (not just interactive shells)
#
# WHAT DOES NOT BELONG HERE:
# - Aliases (only work in interactive shells, put in .zshrc)
# - Functions (put in .zshrc)
# - Prompts (put in .zshrc)
# - Completions (put in .zshrc)
# - Shell options (put in .zshrc)
# - Anything that produces output (breaks scp, rsync, etc.)
# - Slow operations (sourced for every shell, keep it fast)
#
# KEEP THIS FILE MINIMAL - it's sourced constantly

# XDG Base Directory Specification
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Zsh configuration directory
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Dotfiles
export DOTFILES_HOME="$HOME/.dotfiles"

# Locale settings
export LANG=en_US.UTF-8
export LC_TIME=en_IE.UTF-8

# Default programs
export BROWSER="$HOME/.local/bin/linkhandler"
export EDITOR="nvim"
export VISUAL="$EDITOR"

# Keep path arrays free of duplicates. Prepending an entry that already
# exists moves it to the front, which is what makes re-sourcing this file
# from .zprofile (after macOS path_helper reorders PATH) safe.
typeset -U path fpath manpath

# Secrets
source "$ZDOTDIR/.zshenv_secrets"

# Platform-specific environment setup
if [[ "$(uname)" == "Darwin" ]]; then
    # Source macOS environment configuration
    [ -f "$ZDOTDIR/.zshenv_darwin" ] && source "$ZDOTDIR/.zshenv_darwin"
else
    # Source Linux environment configuration
    [ -f "$ZDOTDIR/.zshenv_linux" ] && source "$ZDOTDIR/.zshenv_linux"
fi

# User binaries go last so they take precedence over everything above
path=("$HOME/.local/bin" "$HOME/.cargo/bin" $path)
export PATH

