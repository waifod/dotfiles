# Prompt: starship (config in ~/.config/starship.toml). The full init script
# is cached; the cache regenerates when the starship binary changes.
if (( $+commands[starship] )); then
    _cached_source starship "" starship init zsh --print-full-init
    return
fi

# Fallback where starship is not installed. Based on
# https://dev.to/cassidoo/customizing-my-zsh-prompt-3417
autoload -Uz vcs_info add-zsh-hook
add-zsh-hook precmd vcs_info

# msg_0 = branch; msg_1 = in-progress action (rebase, merge, ...), if any
zstyle ':vcs_info:git:*' formats '%b'
zstyle ':vcs_info:git:*' actionformats '%b' '%a'

setopt prompt_subst
PROMPT='
%F{cyan}%n%f%F{red}@%f%F{green}%m%f %F{yellow}%~%f %F{magenta}${vcs_info_msg_0_}%f %F{red}${vcs_info_msg_1_}%f
%F{cyan}%D{%H:%M:%S}%f %F{yellow}$%f '
