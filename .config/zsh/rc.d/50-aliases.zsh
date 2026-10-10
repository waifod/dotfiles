# Aliases. Replacements are guarded so a fresh machine without the tool
# keeps the standard command. $+commands is a hash lookup, no subprocess.

alias cfg='git --git-dir="${DOTFILES_HOME:-$HOME/.dotfiles}" --work-tree="$HOME"'

(( $+commands[bat] ))  && alias cat='bat --paging=never' less='bat'
(( $+commands[dust] )) && alias du='dust'
(( $+commands[eza] ))  && alias ls='eza'
(( $+commands[fd] ))   && alias find='fd'
(( $+commands[rg] ))   && alias grep='rg'

alias cgc='clang++ -std=c++20 -Wall -Wextra -g -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -O2 -o a'
(( $+commands[g++-14] )) && alias g++='g++-14 -std=c++20 -Wall -Wextra -g -O2 -o a'

if (( $+commands[uv] )); then
    alias python='uv run python'
    alias pip='uv pip'
fi

# Remote builds on Hetzner
alias rhb='remote-build hetzner'        # default: make
alias rhbm='remote-build hetzner make'
