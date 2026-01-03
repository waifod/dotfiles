# .zprofile - Login shells only
# One-time setup: SSH agents, starting services, login messages

if [[ "$(uname)" == "Darwin" ]]; then
    [ -f "$ZDOTDIR/.zprofile_darwin" ] && source "$ZDOTDIR/.zprofile_darwin"
else
    [ -f "$ZDOTDIR/.zprofile_linux" ] && source "$ZDOTDIR/.zprofile_linux"
fi
