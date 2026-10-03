
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.pre.zsh"

# .zprofile - login shells only (after .zshenv, before .zshrc).
# One-time setup: PATH fix-ups, SSH agents.

if [[ $OSTYPE == darwin* ]]; then
    # /etc/zprofile runs path_helper between .zshenv and here, moving
    # /usr/bin and friends ahead of Homebrew. Restore our order; typeset -U
    # drops the duplicates and keeps anything path_helper added.
    path=($_zshenv_path $path)
    export PATH
else
    # SSH agent credentials
    (( $+commands[keychain] )) && eval "$(keychain --eval --quiet --noask id_ed25519)"
fi


# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.post.zsh"
