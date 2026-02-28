# Environment
export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:/Users/dave/.local/bin" # pipx
export EDITOR='vim'
export HOMEBREW_GITHUB_API_TOKEN=$(cat ~/.secrets/homebrew_token)


# Oh-my-zsh 
export ZSH="/Users/dave/.oh-my-zsh"
DISABLE_COMPFIX=true # reduce startup time, trust execution permissions
skip_global_compinit=1 # prevent dupe compinit call
ZSH_THEME="robbyrussell" # https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
plugins=(git dotenv)
source $ZSH/oh-my-zsh.sh
# Only reload completions every 24 hrs rather than every startup
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C  # use cache
fi


# Alias
alias adog='git log --all --decorate --oneline --graph'
alias cpwd='pwd|tr -d "\n"|pbcopy'  # copy current dir to clipboard


# Tools
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# History
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY   # write immediately, not on shell exit


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
