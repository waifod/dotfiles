# env/darwin.zsh - macOS (Amazon laptop) environment for ALL shells.
# Sourced from .zshenv.

# Homebrew (Apple Silicon). Equivalent to `brew shellenv`, hardcoded for speed.
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
export MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}:"
export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}"

# macOS SDK. xcrun defaults to the newest SDK present (a stray 27.0 one that
# the 26.x linker cannot read), so pin to the symlink the CLT installer
# maintains for the running OS.
export SDKROOT="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"

# Kepler SDK
export KEPLER_SDK_PATH="$HOME/kepler/sdk/current"

# Newest Kepler kntools SDK, if any (N: no error if absent, On: name descending)
_kntools=($HOME/.kepler/kntools/sdk/*(N/On[1]))

# Highest precedence first. Homebrew opt/ entries shadow their unversioned
# counterparts in /opt/homebrew/bin and the system.
path=(
    "$HOME/.aki/bin"
    "$HOME/.aim/mcp-servers"
    "$HOME/.lyra/bin/lyra"
    "$KEPLER_SDK_PATH/bin"
    $_kntools
    "$HOME/.flax/bin"
    "$HOME/.toolbox/bin"
    "$HOME/scripts"
    "$HOMEBREW_PREFIX/opt/llvm/bin"
    "$HOMEBREW_PREFIX/opt/ruby/bin"
    "$HOMEBREW_PREFIX/opt/scala@2.12/bin"
    "$HOMEBREW_PREFIX/bin"
    "$HOMEBREW_PREFIX/sbin"
    $path
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
)
unset _kntools

# Disable Apple Terminal's per-tab session history ($ZDOTDIR/.zsh_sessions).
# Must be set before /etc/zshrc_Apple_Terminal runs, i.e. here.
export SHELL_SESSIONS_DISABLE=1
