
# Added by Kiro CLI
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="${PATH:+$PATH:}$HOME/.local/bin" ;; esac

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


