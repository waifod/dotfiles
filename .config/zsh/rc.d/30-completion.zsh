# Completion system. Must run before plugins (fzf-tab needs compinit first).

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# Full rebuild (with the compaudit security scan) at most once a day;
# otherwise load the dump as-is. The glob qualifier only expands when the
# dump exists and was modified within the last 24 hours. `-u` skips the
# insecure-directory prompt, as before.
autoload -Uz compinit
() {
    if (( $# )); then
        compinit -C -d "$1"
    else
        mkdir -p "$XDG_CACHE_HOME/zsh"
        compinit -u -d "$XDG_CACHE_HOME/zsh/zcompdump"
        # compinit only rewrites the dump when fpath changed; mark it checked.
        touch "$XDG_CACHE_HOME/zsh/zcompdump"
    fi
} $XDG_CACHE_HOME/zsh/zcompdump(N.mh-24)

# Bash-style completions (aws_completer and similar)
autoload -Uz bashcompinit && bashcompinit

setopt auto_menu
setopt auto_list
setopt menu_complete

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
