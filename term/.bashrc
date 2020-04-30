# Bashrc is used to configure terminal instances


#########
# VISUAL 
#########

# Customize the bash prompt
if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias __git_ps1="git branch 2>/dev/null | grep '*' | sed 's/* \(.*\)/ (\1)/'"
fi
COLOR1="\[\033[0;34m\]" #Light blue
COLOR2="\[\033[0;37m\]" #Light grey
COLOR3="\[\033[0;32m\]" #Light green
COLOR4="\[\033[0;36m\]" #Light teal
COLOR5="\[\033[0;35m\]" #Light purple
COLOR6="\[\033[0m\]"    #Reset all
PS1="$COLOR1\u$COLOR2:$COLOR3\w$COLOR4\$(__git_ps1) $COLOR5\$ $COLOR6"

# Customize the title bar
PROMPT_TITLE='echo -ne "\033]0;conda:${CONDA_DEFAULT_ENV}@${HOSTNAME%%.*}\007"'
export PROMPT_COMMAND="${PROMPT_TITLE}"


###################
# CUSTOMIZE RANDOS
###################

# Change options of built ins
alias cp='cp -i'   # prompt before overwrite
alias mv='mv -i'   # prompt before overwrite
alias du='du -kh'  # du nicely shows disk usage
alias ls='ls -G'   # make ls use nice colors
alias la='ls -Al'  # la shows all files (including dot files)

# Navigation and inspection
alias j='jobs -l'                   # j shows jobs
alias which='type -a'               # which shows what a command resolves to 
alias ..='cd ..'                    # .. bumps you up a directory
alias ...='cd ...'                  # ... up two
alias cpwd='pwd|tr -d "\n"|pbcopy'  # copy current dir to clipboard
alias cl='clear'                    # clear screen
set mark-symlinked-directories on   # cd into symlinks without double tab

# We like the vim
export EDITOR=vim

# Make git log work better
alias adog='git log --all --decorate --oneline --graph'

# Let us quicklook
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias ql="qlmanage -p &>/dev/null"
fi

##########
# HISTORY 
##########

# Search bash history with up/down arrows
if [ -t 1 ]; then
    bind '"\e[A"':history-search-backward
    bind '"\e[B"':history-search-forward
fi
# Have a good memory
export HISTFILESIZE=10000

# Dynamically update .bash_history
# can display with watch -n 1 -t tail -n 3 .bash_history
export HISTCONTROL=ignoredups:erasedups  # ignore dupes
shopt -s histappend  # append instead of overwrite
#export PROMPT_COMMAND="${PROMPT_COMMAND} history -a;"  # write as you go

# fuzzy finder support
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

########################
# External customization
########################

#######
# LOCAL 
#######
# Enable local bash customization, per machine basis
if [ -f ~/.bash_local ]; then
    source ~/.bash_local
fi
