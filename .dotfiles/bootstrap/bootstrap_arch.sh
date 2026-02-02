#!/bin/bash
set -e
trap 'echo "ERROR: Bootstrap failed at line $LINENO"' ERR

echo -e "\n=== Arch Setup ===\n"

# --- Create XDG directories ---
mkdir -p "$HOME/desktop" "$HOME/downloads" "$HOME/templates" "$HOME/public" \
         "$HOME/docs" "$HOME/music" "$HOME/pics" "$HOME/videos"

echo "Installing packages via Pacman..."
sudo pacman -S --needed --noconfirm \
  git zsh zsh-completions tmux neovim alacritty \
  base-devel clang benchmark perf \
  rustup mise uv sheldon \
  bat eza fd ripgrep dust bottom zoxide git-delta fzf \
  git-lfs unison syncthing wget \
  mpv yt-dlp newsboat transmission-cli \
  sway gammastep bemenu swaylock swayidle grim mako ddcutil \
  pipewire pipewire-pulse pamixer \
  firefox \
  ttf-jetbrains-mono-nerd noto-fonts noto-fonts-cjk noto-fonts-emoji

# Install paru if not present
if ! command -v paru >/dev/null 2>&1; then
  echo -e "\nInstalling Paru..."
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  (cd /tmp/paru && makepkg -si --noconfirm)
  rm -rf /tmp/paru
fi

echo -e "\nInstalling AUR packages via Paru..."
paru -S --needed --noconfirm tremc protonpass-bin nyaa google-chrome-bin

# Initialize rustup
export PATH="$HOME/.cargo/bin:$PATH"
if ! rustup show active-toolchain >/dev/null 2>&1; then
  echo -e "\nSetting up default Rust toolchain..."
  rustup default stable
fi

# Syncthing (user service)
systemctl --user enable --now syncthing
