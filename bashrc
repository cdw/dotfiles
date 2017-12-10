# Bashrc is used to configure terminal instances

# Enable local bash customization, per machine basis
if [ -f ./.bash_local ]; then
            source .bash_local
fi

#########
# VISUAL 
#########

# Customize the bash prompt
COLOR1="\[\033[0;34m\]" #Light blue
COLOR2="\[\033[0;37m\]" #Light grey
COLOR3="\[\033[0;32m\]" #Light green
COLOR4="\[\033[0;35m\]" #Light purple
COLOR5="\[\033[0m\]"    #Reset all
PS1="$COLOR1\u$COLOR2:$COLOR3\w$COLOR4 \$ $COLOR5"

# Customize the title bar
PROMPT_TITLE='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
export PROMPT_COMMAND="${PROMPT_COMMAND} ${PROMPT_TITLE}; "


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
alias j='jobs -l'       # j shows jobs
alias which='type -a'   # which shows what a command resolves to 
alias ..='cd ..'        # .. bumps you up a directory

# We like the vim
export EDITOR=vim

# Enable bash completion in interactive shells and have a good memory
# Locally or via Homebrew
if [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
fi
if [ -f $(brew --prefix)/etc/bash_completion ]; then
            . $(brew --prefix)/etc/bash_completion
fi

##########
# HISTORY 
##########

# h shows the last 30 entries
alias h='history 30'    

# search bash history with up/down arrows
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

# have a good memory
export HISTFILESIZE=5000
