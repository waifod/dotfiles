# Autoload every file in functions/; each is defined on first call.
# -U disables alias expansion inside them, so they call real commands.
fpath=("$ZDOTDIR/functions" $fpath)
autoload -Uz $ZDOTDIR/functions/*(N.:t)
