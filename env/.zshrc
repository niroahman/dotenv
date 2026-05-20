eval "$($HOME/homebrew/bin/brew shellenv)"
export PATH="$HOME/scripts:$HOME/homebrew/bin:$HOME/homebrew/sbin:$HOME/.local/bin:$PATH"
export HOMEBREW_CASK_OPTS="--appdir=~/Documents"

# deno
if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then
    export FPATH="$HOME/.zsh/completions:$FPATH"
fi
. "$HOME/.deno/env"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# sheldon (must load before compinit so zsh-completions fpath is set)
eval "$(sheldon source)"

# fzf (brew-installed)
source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"

# completions
autoload -Uz compinit
compinit

alias tmuxsave='tmux run-shell ~/.config/tmux/plugins/tmux-resurrect/scripts/save.sh'

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# brew wrapper — auto-syncs Brewfile after installs
brew() {
    command brew "$@"
    local exit_code=$?
    case "$1" in
        install|uninstall|remove|reinstall|upgrade)
            brewsync
            ;;
    esac
    return $exit_code
}

# Personal AI dev system
export PATH="$HOME/dev-system/bin:$PATH"
