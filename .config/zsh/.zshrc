# History settings
source "$ZDOTDIR/.zsh_history"

# Shell options
source "$ZDOTDIR/.zsh_options"

# Load plugin manager
source "$ZDOTDIR/.zsh_plugins"

# Aliases and functions
source "$ZDOTDIR/.zsh_aliases"
source "$ZDOTDIR/.zsh_functions"

# Prompt configuration
source "$ZDOTDIR/.zsh_prompt"

# Completion settings
source "$ZDOTDIR/.zsh_completions"

# Key bindings
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey "\C-p" history-beginning-search-backward
bindkey "\C-n" history-beginning-search-forward

# NVM (Node Version Manager) loading
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Bat and Less configuration
# Use bat as the default pager, which includes syntax highlighting.
# Use --paging=always to ensure bat always uses a pager.
export PAGER="bat --paging=always"

# This prevents raw ANSI codes from being produced.
# The "-c" option tells the man page formatter to not use color.
export MANROFFOPT="-c"

# Ensure man pages also use bat for paging, with specific themes.
export MANPAGER="sh -c 'col -bx | bat -l man --paging=always --theme=gruvbox-dark'"

export BAT_THEME="gruvbox-dark"
export DELTA_THEME="gruvbox-dark"
