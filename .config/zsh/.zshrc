try_source() { [ -f "$1" ] && source "$1" }

# Should clean up PATH
export PATH=$HOME/.cargo/bin:$PATH

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws
alias bb='brazil-build'
alias bws='brazil workspace'
ENABLE_CORRECTION="true"
setopt auto_cd

bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward
bindkey "\C-p" history-beginning-search-backward
bindkey "\C-n" history-beginning-search-forward

export PROMPT="
%{$fg[white]%}(%D %*) <%?> [%~] $program %{$fg[default]%}
%{$fg[cyan]%}%m %#%{$fg[default]%} "

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


eval "$(fzf --zsh)"

# Neovim is my default editor
export EDITOR="nvim"
export VISUAL="$EDITOR"

# Set bat color scheme
export BAT_THEME="gruvbox-dark"

# Aliases and functions
if [[ -n "$XDG_CONFIG_HOME" && -d "$XDG_CONFIG_HOME"/zsh ]]; then
    source "$XDG_CONFIG_HOME"/zsh/.zsh_aliases
    source "$XDG_CONFIG_HOME"/zsh/.zsh_functions
else
    source "$HOME"/.zsh_aliases
    source "$HOME"/.zsh_functions
fi

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

if [ "$(uname)" == "Darwin" ]; then
  # Load plugins via Antidote
  try_source "$HOMEBREW_PREFIX"/opt/antidote/share/antidote/antidote.zsh && antidote load "${ZDOTDIR:-$HOME}"/.zsh_plugins.txt

  export DEV_CNAME="dumatte-dev.aka.corp.amazon.com"
  export WEBPACK_DEV_SERVER_PORT=4000
  export DEV_OVERRIDE=1
  eval "$(brew shellenv)"
  export ANDROID_HOME="/Users/dumatte/Library/Android/sdk"
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home"
  alias python='/opt/homebrew/bin/python3'
  export PATH="/opt/homebrew/opt/node@18/bin:$PATH"
  export PATH=/usr/local/bin/aws_completer:/opt/homebrew/opt/llvm/bin:/opt/homebrew/opt/ruby/bin:/opt/homebrew/bin:/opt/homebrew/opt/scala@2.12/bin:$HOME/.rbenv/bin:$HOME/.toolbox/bin:$HOME/scripts:$PATH
fi
