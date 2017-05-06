########### Environment Variables ###########
export PATH=$PATH:/scripts/bash
export TERM=xterm-256color
if [ $EUID -eq 0 ]; then
    # root prompt
    export PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\$ \[\e[m\]\[\e[0;32m\]'
else
    # user prompt
    export PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
fi

########### Aliases ########### 
alias start-emacs='emacs --daemon'
alias kill-emacs='emacsclient -e '\''(kill-emacs)'\'''
alias edit='emacsclient -c -nw'


########### Start up commands ###########

########### Bash Functions ###########
