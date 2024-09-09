# Should clean up PATH
export PATH=/usr/local/bin/aws_completer:/opt/homebrew/opt/llvm/bin:/opt/homebrew/opt/ruby/bin:/opt/homebrew/bin:/opt/homebrew/opt/scala@2.12/bin:$HOME/.rbenv/bin:$HOME/.toolbox/bin:$HOME/scripts:$PATH

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

############################
# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
############################

export ANDROID_HOME="/Users/dumatte/Library/Android/sdk"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home"
alias python='/opt/homebrew/bin/python3'

export PROMPT="
%{$fg[white]%}(%D %*) <%?> [%~] $program %{$fg[default]%}
%{$fg[cyan]%}%m %#%{$fg[default]%} "

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export DEV_CNAME="dumatte-dev.aka.corp.amazon.com"
export WEBPACK_DEV_SERVER_PORT=4000

export DEV_OVERRIDE=1

eval "$(starship init zsh)"
eval "$(ssh-agent -s)"
eval "$(fzf --zsh)"
eval "$(brew shellenv)"

alias ctbs='clang-tidy -p ./build --color --quiet ./src/*'

# Rust stuff - cleanup?
. "$HOME/.cargo/env"

# Aliases and functions
if [[ -n "$XDG_CONFIG_HOME" && -d "$XDG_CONFIG_HOME"/zsh ]]; then
    source "$XDG_CONFIG_HOME"/zsh/.zsh_aliases
    source "$XDG_CONFIG_HOME"/zsh/.zsh_functions
else
    source "$HOME"/.zsh_aliases
    source "$HOME"/.zsh_functions
fi
