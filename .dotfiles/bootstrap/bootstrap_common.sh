#!/bin/bash
set -e
trap 'echo "ERROR: Bootstrap failed at line $LINENO"' ERR

DOTFILES_REPO="https://github.com/waifod/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

echo -e "\n=== Common Setup ===\n"

# --- Create directories ---
mkdir -p "$HOME/.local/state/zsh"
mkdir -p "$HOME/.local/state/unison"
mkdir -p "$HOME/sync"

# --- Dotfiles ---
if [ ! -d "$DOTFILES_DIR" ]; then
  echo -e "\nCloning dotfiles..."
  git clone --bare "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

cfg() {
  /usr/bin/git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

cfg config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
cfg config status.showUntrackedFiles no

mkdir -p "$HOME/.config-backup"

if cfg checkout 2>/dev/null; then
  echo -e "\nChecked out config."
else
  echo -e "\nBacking up pre-existing dotfiles."
  cfg checkout 2>&1 | awk '/^\s+/ {print $1}' | while read -r file; do
    mkdir -p "$HOME/.config-backup/$(dirname "$file")"
    mv "$HOME/$file" "$HOME/.config-backup/$file"
  done
  cfg checkout
fi

export PATH="$HOME/.cargo/bin:$PATH"

# --- Cargo tools ---
if ! cargo install-update --version >/dev/null 2>&1; then
  echo -e "\nInstalling cargo-update..."
  cargo install cargo-update
fi

# --- TPM ---
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  echo -e "\nInstalling TPM..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

# --- Sheldon plugins ---
if command -v sheldon >/dev/null 2>&1; then
  echo -e "\nInstalling sheldon plugins..."
  sheldon lock
fi

# --- Mise runtimes ---
if command -v mise >/dev/null 2>&1; then
  echo -e "\nInstalling mise runtimes..."
  mise install
fi

# --- Neovim plugins ---
if command -v nvim >/dev/null 2>&1; then
  echo -e "\nInstalling Neovim plugins..."
  nvim --headless "+Lazy! sync" +qa
fi

# --- Change default shell to zsh ---
if [ "$SHELL" != "$(which zsh)" ]; then
  echo -e "\nChanging default shell to zsh..."
  chsh -s "$(which zsh)"
fi

echo -e "\n=== Bootstrap complete ==="
echo -e "\nNext steps:\n"
echo "  1. Log out and back in (or run 'zsh') to use the new shell"
echo ""
echo "  2. Configure syncthing at http://localhost:8384"
echo "     For remote servers: ssh -L 8384:localhost:8384 <host>"
echo "     Guide: https://docs.syncthing.net/intro/getting-started.html"
