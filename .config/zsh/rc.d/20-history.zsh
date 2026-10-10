# History
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=10000
[[ -d ${HISTFILE:h} ]] || mkdir -p ${HISTFILE:h}

setopt share_history          # share across sessions
setopt extended_history       # record timestamp and duration
setopt hist_ignore_all_dups   # drop older duplicate when a command repeats
setopt hist_save_no_dups
setopt hist_expire_dups_first
setopt hist_verify            # show expanded history before running it
