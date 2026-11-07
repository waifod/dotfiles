#!/bin/bash
set -eEo pipefail
trap '_l=$LINENO; [ -z "${FUNCNAME:-}" ] || _l="${BASH_LINENO[0]} (in ${FUNCNAME}())"; echo "ERROR: ${0##*/} failed at line $_l" >&2' ERR

DOTFILES_REPO="https://github.com/waifod/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

echo -e "\n=== Common Setup ===\n"

# Each bootstrap_<os>.sh runs in its own process, so PATH changes made there
# (Homebrew on macOS, ~/.local/bin from the mise installer on Fedora) do not
# reach this script.
if [ "$(uname -s)" = Darwin ]; then
  [ -x /opt/homebrew/bin/brew ] || { echo "ERROR: Homebrew not found at /opt/homebrew/bin/brew; run bootstrap.sh, which installs it" >&2; exit 1; }
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# --- Create directories ---
mkdir -p "$HOME/.local/state/zsh"
mkdir -p "$HOME/.local/state/unison"
mkdir -p -m 700 "$HOME/.ssh" "$HOME/.ssh/sockets"
mkdir -p "$HOME/sync"

# --- Dotfiles ---
if [ ! -d "$DOTFILES_DIR" ]; then
  echo -e "\nCloning dotfiles..."
  # The tracked .dotfiles/config replaces the clone's and expects files refs (format 0).
  git clone --bare --ref-format=files "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

cfg() {
  # fsmonitor off: the work tree is $HOME. The tracked repo config
  # (.dotfiles/config) disables it, but on a first run that file is only in
  # place after the checkout below.
  /usr/bin/git -c core.fsmonitor=false --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

cfg config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
cfg config status.showUntrackedFiles no

if [ -e "$DOTFILES_DIR/index" ]; then
  # An index exists, so a checkout has run before. A plain checkout keeps
  # local edits but does not restore deleted tracked files; list those.
  cfg checkout
  missing=$(cfg ls-files --deleted)
  if [ -n "$missing" ]; then
    echo "WARNING: tracked files are missing from \$HOME. Check 'cfg status' and restore with 'cfg checkout -- <path>':" >&2
    echo "$missing" | sed 's/^/  /' >&2
  fi
  echo -e "\nChecked out config."
else
  # First checkout. Files at tracked paths would block it, and one is always
  # there: the repo tracks its own git config (.dotfiles/config), and the bare
  # clone wrote an untracked one at that path. Move every existing tracked
  # path aside; the checkout then writes the tracked versions.
  backup_dir="$HOME/.config-backup/$(date +%Y%m%d-%H%M%S)"
  echo -e "\nBacking up pre-existing dotfiles to $backup_dir"
  cfg ls-tree -r -z --name-only HEAD | while IFS= read -r -d '' file; do
    # A symlink or file at a parent path also blocks the checkout; move the
    # shallowest such parent instead of the file under it.
    target=$file
    dir=$(dirname "$file")
    while [ "$dir" != . ]; do
      if [ -L "$HOME/$dir" ] || { [ -e "$HOME/$dir" ] && [ ! -d "$HOME/$dir" ]; }; then
        target=$dir
      fi
      dir=$(dirname "$dir")
    done
    if [ -e "$HOME/$target" ] || [ -L "$HOME/$target" ]; then
      mkdir -p "$backup_dir/$(dirname "$target")"
      mv "$HOME/$target" "$backup_dir/$target"
      echo "  $target"
    fi
  done
  if ! cfg checkout; then
    echo "ERROR: checkout failed after moving files to $backup_dir." >&2
    echo "Keep that directory: it holds your original files. Fix the path git reports above and rerun;" >&2
    echo "the rerun moves the files git already wrote to a new directory under ~/.config-backup/." >&2
    exit 1
  fi
  # Print the backup reminder at exit, also when a later step fails: a rerun
  # takes the set-up branch above and would not print it.
  trap 'echo ""
echo "Pre-existing files were moved to $backup_dir (originals from an earlier"
echo "failed run are in an older directory under ~/.config-backup/). Review them and"
echo "merge machine-specific settings back (shell environment goes in"
echo "~/.config/zsh/local/env.zsh). The .dotfiles/config copies there are generated"
echo "by git and can be deleted."' EXIT
fi

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

# --- Python ---
if command -v uv >/dev/null 2>&1; then
  echo -e "\nInstalling Python via uv..."
  uv python install 3.12
  # Python tooling the neovim config expects system-wide (Homebrew provides
  # these on macOS; elsewhere they come from uv).
  for tool in ruff ty; do
    command -v "$tool" >/dev/null 2>&1 || uv tool install "$tool"
  done
fi

# --- Neovim plugins ---
if command -v nvim >/dev/null 2>&1; then
  echo -e "\nInstalling Neovim plugins..."
  nvim --headless "+Lazy! sync" +qa
fi

# --- Change default shell to zsh ---
# Skip if the login shell is already any zsh. /bin/zsh is the only zsh in
# macOS's /etc/shells, and the first zsh on PATH there is Homebrew's.
case "$SHELL" in
*/zsh) ;;
*)
  if [ "$(uname -s)" = Darwin ]; then zsh_path=/bin/zsh; else zsh_path=$(command -v zsh); fi
  echo -e "\nChanging default shell to zsh..."
  chsh -s "$zsh_path"
  ;;
esac

echo -e "\n=== Bootstrap complete ==="
echo -e "\nNext steps:\n"
echo "  1. Log out and back in (or run 'zsh') to use the new shell"
echo ""
echo "  2. Configure syncthing at http://localhost:8384"
echo "     For remote servers: ssh -L 8384:localhost:8384 <host>"
echo "     Guide: https://docs.syncthing.net/intro/getting-started.html"
