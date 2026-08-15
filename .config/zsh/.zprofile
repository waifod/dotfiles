
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.pre.zsh"

# .zprofile - Login shells only
# One-time setup: SSH agents, starting services, login messages

if [[ "$(uname)" == "Darwin" ]]; then
    [ -f "$ZDOTDIR/.zprofile_darwin" ] && source "$ZDOTDIR/.zprofile_darwin"
else
    [ -f "$ZDOTDIR/.zprofile_linux" ] && source "$ZDOTDIR/.zprofile_linux"
fi


# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.post.zsh"
