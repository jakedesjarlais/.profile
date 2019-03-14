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


########### Functions ##############

function gst {
	git status
}

function gcm {
	git checkout master
}

function gb {
	git branch
}

function gch {
	COMMIT=$1
	# If we arn't given a commit assume it's the previous commit
	if [ -z "$COMMIT" ]; then
		COMMIT=HEAD~
	fi

	git diff --name-only $COMMIT
}

function tcprelay {
	/usr/local/bin/tcprelay --portoffset 2000 ssh rsync scp &
}

function ipad_root {
	ssh -o NoHostAuthenticationForLocalhost=yes -p 2022 root@localhost
}

function ipad {
	ssh -o NoHostAuthenticationForLocalhost=yes -p 2022 mobile@localhost
}

function ipad_scp {
	scp -o NoHostAuthenticationForLocalhost=yes -r -P 2022 "$1" "$2"
}

function dlist {
	sudo darwinup list
}

function dinst {
	sudo darwinup install "$1"
}

function duinst {
	sudo darwinup uninstall "$1"
}

function dpop {
	sudo darwinup uninstall newest
}


########### Start up commands ######


########### Bash Functions #########


########### Git Setup ##############

export GIT_EDITOR=vim
source /usr/local/bin/git-completion.bash
source /usr/local/bin/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
txtred="$(tput setaf 9)"
txtcyn="$(tput setaf 6)"
textreset="$(tput sgr 0)"
# TODO
PS1='\[$textreset\]\u@\h \[$txtcyn\]\W\[$txtred\]$(__git_ps1 " (%s)")\[$textreset\] \$ '

