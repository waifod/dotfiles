#!/bin/sh

# xdg-ninja
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh

# dotfiles
export DOTFILES_HOME="$HOME"/.dotfiles

# locale
# Remember to make it available in /etc/locale.gen
export LANG=en_US.UTF-8
export LC_TIME=en_IE.UTF-8
