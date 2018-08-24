########### Environment Variables ###########
export PATH=/scripts/bash:/scripts/bin:/usr/local/cuda-8.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

if [ $EUID -eq 0 ]; then
    # root prompt
    export PS1='\[\033]0;\u@\h:\w\007\]\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
else
    # user prompt
    export PS1='\[\033]0;\u@\h:\w\007\]\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
fi

########### Aliases ################
alias gst='git status'
alias gcm='git checkout master'
alias gb='git branch'

########### Functions ##############

########### Start up commands ######

########### Bash Functions #########


########### Git Setup ##############
export GIT_EDITOR=edit
source /usr/local/bin/git-completion.bash
source /usr/local/bin/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
txtred="$(tput setaf 9)"
txtcyn="$(tput setaf 6)"
textreset="$(tput sgr 0)"
# TODO
PS1='\[$textreset\]\u@\h \[$txtcyn\]\W\[$txtred\]$(__git_ps1 " (%s)")\[$textreset\] \$ '
