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
  git zsh tmux neovim \
  llvm google-benchmark \
  mise uv sheldon starship \
  bat eza fd ripgrep dust bottom zoxide git-delta fzf \
  git-lfs unison syncthing wget \
  mpv yt-dlp newsboat

echo -e "\nInstalling casks..."
brew install --cask --force proton-pass font-jetbrains-mono-nerd-font font-noto-sans font-noto-serif font-noto-sans-mono font-noto-color-emoji font-noto-sans-cjk font-noto-serif-cjk

# Alacritty: the Homebrew cask was disabled on 2026-09-01 (it fails the
# Gatekeeper check), so it has to come from the GitHub releases instead.
if [ ! -d "/Applications/Alacritty.app" ]; then
  echo -e "\nAlacritty is not installed. Download it from"
  echo "https://github.com/alacritty/alacritty/releases (the cask is disabled)."
fi

# Rust: rustup from the official installer, not Homebrew. The Homebrew
# formula is keg-only and has changed names before (rustup-init -> rustup),
# which left ~/.cargo/bin pointing at a deleted binary.
export PATH="$HOME/.cargo/bin:$PATH"
if [ ! -x "$HOME/.cargo/bin/rustup" ]; then
  echo -e "\nInstalling rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi
if ! rustup show active-toolchain >/dev/null 2>&1; then
  echo -e "\nSetting up default Rust toolchain..."
  rustup default stable
fi

# Syncthing
brew services start syncthing
