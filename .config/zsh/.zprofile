if [[ "$(uname)" == "Darwin" ]]; then
    # macOS specific environment variables
    #
    # Homebrew environment
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Setting PATH for Python 2.7
    # The original version is saved in .zprofile.pysave
    export PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"

    # Other macOS-specific exports and aliases from .zshrc
    export DEV_CNAME="dumatte-dev.aka.corp.amazon.com"
    export WEBPACK_DEV_SERVER_PORT=4000
    export DEV_OVERRIDE=1

    # Specific PATH modifications for Homebrew packages and other tools
    export PATH="/opt/homebrew/opt/node@18/bin:/usr/local/bin/aws_completer:/opt/homebrew/opt/llvm/bin:/opt/homebrew/opt/ruby/bin:/opt/homebrew/bin:/opt/homebrew/opt/scala@2.12/bin:$HOME/.rbenv/bin:$HOME/.toolbox/bin:$HOME/scripts:$PATH"

    # macOS specific aliases
    alias python='/opt/homebrew/bin/python3'
else
    # Linux specific environment
    
    # Set up SSH agent credentials
    # We do this here as it's a login-only action.
    eval $(keychain --eval --quiet --noask id_ed25519)
fi
