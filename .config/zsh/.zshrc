
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

# .zshrc - interactive shells only.
#
#   rc.d/*.zsh     shared config, loaded in filename order
#   os/<os>*.zsh   platform config (darwin = Amazon laptop)
#   local/*.zsh    untracked machine-local config (secrets.zsh is loaded
#                  from .zshenv instead, so it is skipped here)
#   functions/     autoloaded on first call

# Sourced at top level, not in a function: `typeset` inside sourced plugin
# code would otherwise create function-local variables.
if [[ $OSTYPE == darwin* ]]; then _os=darwin; else _os=linux; fi
for _f in $ZDOTDIR/rc.d/*.zsh(N) $ZDOTDIR/os/$_os*.zsh(N) $ZDOTDIR/local/*.zsh(N); do
    [[ $_f == */local/secrets.zsh ]] || source "$_f"
done
unset _f _os

# zoxide wants to initialise last, after anything that touches `cd`.
_cached_source zoxide "" zoxide init zsh --cmd cd


# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"
