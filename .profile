# Environment Variables
export P4CONFIG=/.p4config
if [ $EUID -eq 0 ]; then
    # root prompt
    export PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\$ \[\e[m\]\[\e[0;32m\]'
else
    # user prompt
    export PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
fi

# Aliases
alias start-emacs='env TERM=xterm-256color emacs --daemon'
alias kill-emacs='env TERM=xterm-256color emacsclient -e '\''(kill-emacs)'\'''
alias edit='env TERM=xterm-256color emacsclient -c -nw'


# Start up commands

# Bash Functions