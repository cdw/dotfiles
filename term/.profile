# Bash profile (this) is executed when logging in as a user
# but not when launching a sub-shell through tmux or screen

# Also run the configuration for terminal instances
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

#######################
# ENVIRONMENT VARIABLES
#######################

