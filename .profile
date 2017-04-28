########### Environment Variables ###########
export P4CONFIG=/.p4config
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
alias lsp4='p4 changes -l -u jdesjarlais | less'
alias sshvm='ssh jake@192.168.1.85'
alias ssh-orange='ssh -p 50500 jdesjarlais@orange.ece.utexas.edu'
alias ssh-banana='ssh -p 50500 jdesjarlais@banana.ece.utexas.edu'


########### Start up commands ###########

########### Bash Functions ###########
