#!/bin/bash
set -e
trap 'echo "ERROR: Bootstrap failed at line $LINENO"' ERR

echo -e "\n=== macOS Setup ===\n"

# Install Homebrew if not present
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo ""
fi

echo "Installing packages via Homebrew..."
brew install \
  git zsh tmux neovim llvm \
  uv mise sheldon rustup \
  bat eza fd ripgrep dust bottom zoxide git-delta fzf \
  git-lfs unison syncthing \
  mpv yt-dlp wget \
  newsboat

echo -e "\nInstalling casks..."
brew install --cask --force alacritty proton-pass font-jetbrains-mono-nerd-font font-noto-sans font-noto-serif font-noto-sans-mono font-noto-color-emoji font-noto-sans-cjk font-noto-serif-cjk

# Initialize rustup
export PATH="$HOME/.cargo/bin:$PATH"
if ! rustup show active-toolchain >/dev/null 2>&1; then
  echo -e "\nSetting up default Rust toolchain..."
  rustup default stable
fi

# Syncthing
brew services start syncthing
