# ~/.zshenv - bootstrap only. zsh reads this before ZDOTDIR is known;
# everything else lives in $ZDOTDIR. zsh does not read $ZDOTDIR/.zshenv on
# its own once ZDOTDIR is set here, hence the explicit source.
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
source "$ZDOTDIR/.zshenv"
