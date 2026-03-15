# Environment
export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:/Users/dave/.local/bin" # pipx
export EDITOR='vim'
export HOMEBREW_GITHUB_API_TOKEN=$(cat ~/.secrets/homebrew_token)


# Prompt - Close to OMZ robbyrussell exit code & Git status
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr ' %F{yellow}✘%f'
zstyle ':vcs_info:git:*' stagedstr ' %F{red}✘%f'
zstyle ':vcs_info:git:*' formats '(%b)%u%c '
zstyle ':vcs_info:git:*' actionformats '(%b|%a) %u%c'
precmd() { vcs_info }
setopt PROMPT_SUBST
PROMPT='%(?.%F{green}.%F{red})➜%f %F{blue}%~%f %F{magenta}${vcs_info_msg_0_}%f'


# Alias
alias la='ls -a'
alias ..="cd .."
alias adog='git log --all --decorate --oneline --graph'
alias cpwd='pwd|tr -d "\n"|pbcopy'  # copy current dir to clipboard


# History, logging
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY   # write immediately, not on shell exit


# History, searching
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search    # up arrow
bindkey "^[[B" down-line-or-beginning-search  # down arrow


# Conda, lazy-loaded
export CONDA_PATH="/opt/homebrew/Caskroom/miniconda/base/condabin/conda"
conda() {
    echo "Lazy loading conda upon first invocation..."
    unfunction conda
    if [[ -f "$CONDA_PATH" ]]; then
        eval "$($CONDA_PATH shell.zsh hook)"
        conda "$@"
        return
    fi
    echo "No conda installation found at $CONDA_PATH"
}


# Startup
fortune 30% ~/.config/fortune/oblique_ed4 40% ~/.config/fortune/career 20% ~/.config/fortune/oblique_for_se 10% ~/.config/fortune/laws
cd ~


# Local overrides 
[[ -f  ~/.zsh_local ]] && source ~/.zsh_local
