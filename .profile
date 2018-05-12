########### Environment Variables ###########
export PATH=/scripts/bash:/scripts/bin:/usr/local/cuda-8.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH
export TERM=xterm-256color
if [ $EUID -eq 0 ]; then
    # root prompt
    export PS1='\[\033]0;\u@\h:\w\007\]\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
else
    # user prompt
    export PS1='\[\033]0;\u@\h:\w\007\]\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
fi

########### Aliases ########### 
alias ls='ls --color=always' # Show color prompt for ls over ssh

########### Start up commands ###########

########### Bash Functions ###########


