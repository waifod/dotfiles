#!/bin/sh

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
# Remember to make it available in /etc/locale.gen
export LANG=en_US.UTF-8
export LC_TIME=en_IE.UTF-8

# Default programs
export BROWSER="$HOME/.local/bin/linkhandler"
export EDITOR="nvim"
export VISUAL="$EDITOR"

# Core PATH adjustments
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
