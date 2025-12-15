
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

# History settings
source "$ZDOTDIR/.zsh_history"

# Shell options
source "$ZDOTDIR/.zsh_options"

# Load plugin manager
source "$ZDOTDIR/.zsh_plugins"

# Aliases and functions
source "$ZDOTDIR/.zsh_aliases"
source "$ZDOTDIR/.zsh_functions"

# Cross-platform tools
source "$ZDOTDIR/.zsh_tools"

# Prompt configuration
source "$ZDOTDIR/.zsh_prompt"

# Completion settings
source "$ZDOTDIR/.zsh_completions"

# Secrets
source "$ZDOTDIR/.zsh_secrets"

# OS-specific settings
if [[ "$(uname)" == "Darwin" ]]; then
    source "$ZDOTDIR/.zsh_darwin"
else
    source "$ZDOTDIR/.zsh_linux"
fi

# Key bindings
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey "\C-p" history-beginning-search-backward
bindkey "\C-n" history-beginning-search-forward

# Bat and Less configuration
# Use bat as the default pager, which includes syntax highlighting.
# Use --paging=always to ensure bat always uses a pager.
export PAGER="bat --paging=always"

# Setup zoxide
eval "$(zoxide init zsh --cmd cd)"


# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"

. "$HOME/.local/share/../bin/env"
