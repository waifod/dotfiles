
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.pre.zsh"

if [[ "$(uname)" == "Darwin" ]]; then
    # macOS specific environment variables

    # Homebrew environment
    eval "$(/opt/homebrew/bin/brew shellenv)"



    # Other macOS-specific exports and aliases from .zshrc
    export DEV_CNAME="dumatte-dev.aka.corp.amazon.com"
    export WEBPACK_DEV_SERVER_PORT=4000
    export DEV_OVERRIDE=1

    # Specific PATH modifications for Homebrew packages and other tools
    export PATH="/usr/local/bin/aws_completer:/opt/homebrew/opt/llvm/bin:/opt/homebrew/opt/ruby/bin:/opt/homebrew/bin:/opt/homebrew/opt/scala@2.12/bin:$HOME/.rbenv/bin:$HOME/.toolbox/bin:$HOME/scripts:$PATH"


else
    # Linux specific environment
    
    # Set up SSH agent credentials
    # We do this here as it's a login-only action.
    eval $(keychain --eval --quiet --noask id_ed25519)
fi


# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.post.zsh"
