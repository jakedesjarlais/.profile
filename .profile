########### Environment Variables ###########
export P4CONFIG=/.p4config
export LD_LIBRARY_PATH=/sw/dev/gpu_drv/cuda_a/drivers/gpgpu/_out/Linux_amd64_debug/bin/
export PATH=$PATH:/shared/bin
if [ $EUID -eq 0 ]; then
    # root prompt
    export PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\$ \[\e[m\]\[\e[0;32m\]'
else
    # user prompt
    export PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
fi

########### Aliases ########### 
alias start-emacs='env TERM=xterm-256color /usr/local/Cellar/emacs/24.5/bin/emacs-24.5 --daemon'
alias kill-emacs='env TERM=xterm-256color /usr/local/Cellar/emacs/24.5/bin/emacsclient -e '\''(kill-emacs)'\'''
alias edit='env TERM=xterm-256color /usr/local/Cellar/emacs/24.5/bin/emacsclient -c -nw'
alias lsp4='p4 changes -l -u jdesjarlais | less'


########### Start up commands ###########

########### Bash Functions ###########
