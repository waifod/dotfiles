# Plugins (sheldon: ~/.config/sheldon/plugins.toml) and fzf integration.
# Both outputs are cached; see 00-cache.zsh.

_cached_source sheldon "$XDG_CONFIG_HOME/sheldon/plugins.toml" sheldon source
_cached_source fzf "" fzf --zsh

# fzf-tab (ftb-tmux-popup falls back to plain fzf outside tmux)
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
