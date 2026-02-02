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
  clang clang-tools-extra google-benchmark-devel perf openssl-devel \
  uv rustup \
  bat fd-find ripgrep du-dust zoxide git-delta fzf \
  git-lfs unison syncthing wget keychain \
  firewalld fail2ban

# Initialize rustup (Fedora's package requires rustup-init)
if [ ! -d "$HOME/.rustup" ]; then
  echo -e "\nInitializing rustup..."
  rustup-init -y
fi

source "$HOME/.cargo/env"

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

# --- Security hardening ---
echo -e "\nConfiguring security..."

# Disable root SSH and password auth
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Firewall
sudo systemctl enable --now firewalld
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-port=22000/tcp
sudo firewall-cmd --permanent --add-port=21027/udp
sudo firewall-cmd --reload

# Auto security updates
sudo mkdir -p /etc/dnf
echo -e "[commands]\napply_updates = yes" | sudo tee /etc/dnf/automatic.conf > /dev/null
sudo systemctl enable --now dnf5-automatic.timer

# Fail2ban
sudo systemctl enable --now fail2ban

# Syncthing (user service)
systemctl --user enable --now syncthing
