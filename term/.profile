# Bash profile (this) is executed when logging in as a user
# but not when launching a sub-shell through tmux or screen

# Also run the configuration for terminal instances
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

#######################
# ENVIRONMENT VARIABLES
#######################

# Add Homebrew binary location
export PATH=/usr/local/bin:$PATH

# Where is our home java directory? Mostly for bioformats
export JAVA_HOME=$(/usr/libexec/java_home)


