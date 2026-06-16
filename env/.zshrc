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

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

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

# git wrapper — strips Claude co-author lines after commit
git() {
    command git "$@"
    local exit_code=$?
    if [[ $exit_code -eq 0 ]] && [[ "$1" == "commit" ]]; then
        local msg
        msg=$(command git log -1 --format="%B" 2>/dev/null)
        if echo "$msg" | grep -qE '^Co-[Aa]uthored-[Bb]y:.*[Cc]laude|^.?Generated with.*[Cc]laude'; then
            local cleaned
            cleaned=$(echo "$msg" \
                | grep -vE '^Co-[Aa]uthored-[Bb]y:.*[Cc]laude' \
                | grep -vE '^.?Generated with.*[Cc]laude' \
                | sed -e 's/[[:space:]]*$//')
            # trim trailing blank lines
            cleaned=$(echo "$cleaned" | awk 'NF{p=NR} NR<=p')
            printf '%s\n' "$cleaned" | command git commit --amend -F - --no-edit 2>/dev/null
        fi
    fi
    return $exit_code
}

# direnv — auto-activate .venv when entering project dirs
eval "$(direnv hook zsh)"

# Personal AI dev system
export PATH="$HOME/dev-system/bin:$PATH"
# Docker CLI completions
fpath=($HOME/.docker/completions $fpath)
export PATH="$PATH:/Users/niroahman/go/bin"
alias aws="/Users/niroahman/homebrew/bin/aws"

# secrets (not tracked in dotenv repo)
[[ -f "$HOME/.secrets/env.zsh" ]] && source "$HOME/.secrets/env.zsh"
