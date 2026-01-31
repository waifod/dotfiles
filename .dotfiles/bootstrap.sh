#!/bin/sh
set -e

git clone --bare https://github.com/waifod/dotfiles.git "$HOME/.dotfiles"

cfg() {
  /usr/bin/git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
}

cfg config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
cfg config status.showUntrackedFiles no

mkdir -p "$HOME/.config-backup"

if cfg checkout 2>/dev/null; then
  echo "Checked out config."
else
  echo "Backing up pre-existing dotfiles."
  cfg checkout 2>&1 | awk '/^\s+/ {print $1}' | xargs -I{} mv "$HOME/{}" "$HOME/.config-backup/{}"
  cfg checkout
fi
