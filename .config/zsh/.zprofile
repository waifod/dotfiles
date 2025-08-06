if [[ "$(uname)" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Setting PATH for Python 2.7
    # The original version is saved in .zprofile.pysave
    PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
    export PATH
fi

eval $(keychain --eval --quiet --noask id_ed25519)
