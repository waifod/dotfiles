# Cache the output of `eval "$(tool init zsh)"`-style commands.
#
# Usage: _cached_source <name> <dep-file|""> <command> [args...]
#
# Regenerates $XDG_CACHE_HOME/zsh/<name>.zsh when it is missing, when the
# resolved path of <command> changes (Homebrew upgrades land in a new Cellar
# directory), or when <dep-file> is newer than the cache. Delete the cache
# directory to force regeneration.
_cached_source() {
    local name=$1 dep=$2; shift 2
    local bin=${commands[$1]}
    [[ -n $bin ]] || return 0
    bin=${bin:A}
    local cache=$XDG_CACHE_HOME/zsh/$name.zsh stamp="# bin: $bin"
    local first
    [[ -r $cache ]] && read -r first < $cache
    if [[ $first != "$stamp" || ( -n $dep && $dep -nt $cache ) ]]; then
        mkdir -p ${cache:h}
        { print -r -- $stamp; "$@" } >| $cache.$$ && mv -f $cache.$$ $cache
    fi
    source $cache
}
