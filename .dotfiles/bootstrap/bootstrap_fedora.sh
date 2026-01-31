#!/bin/bash
set -e
trap 'echo "ERROR: Bootstrap failed at line $LINENO"' ERR

echo -e "\n=== Fedora Setup ===\n"

# --- Create XDG directories ---
mkdir -p "$HOME/desktop" "$HOME/downloads" "$HOME/templates" "$HOME/public" \
         "$HOME/docs" "$HOME/music" "$HOME/pics" "$HOME/videos"

echo "Installing packages via DNF..."
sudo dnf install -y \
  git zsh tmux neovim \
  uv rustup \
  bat fd-find ripgrep du-dust zoxide git-delta fzf \
  git-lfs unison wget \
  openssl-devel

# Initialize rustup
export PATH="$HOME/.cargo/bin:$PATH"
if ! rustup show active-toolchain >/dev/null 2>&1; then
  echo -e "\nSetting up default Rust toolchain..."
  rustup default stable
fi

# mise via shell script on Fedora
if ! command -v mise >/dev/null 2>&1; then
  echo -e "\nInstalling mise..."
  curl https://mise.run | sh
fi

# Tools not in Fedora repos, install via cargo
if ! command -v eza >/dev/null 2>&1; then
  echo -e "\nInstalling eza via cargo..."
  cargo install eza
fi

if ! command -v btm >/dev/null 2>&1; then
  echo -e "\nInstalling bottom via cargo..."
  cargo install bottom
fi

if ! command -v sheldon >/dev/null 2>&1; then
  echo -e "\nInstalling sheldon via cargo..."
  cargo install sheldon
fi
