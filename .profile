########### Environment Variables ###########
export PATH=~/.profile.d/scripts/bash:~/.profile.d/scripts/bin:/usr/local/cuda-8.0/bin:$PATH
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

function gc {
	git checkout $1
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
    if [ ! -z $1 ]; then
        rootPath=$1

        projectName="$(echo "$1" | tr A-Z a-z)"
        if [ $projectName = "avkit" ];then
            rootPath="/tmp/AVKit_avkit.roots/Archives/Shared_AVKit_avkit_DSTROOT_osx.tar.gz"
        elif [ $projectName = "qtpx" ] || [ $projectName = "quicktime" ] || [ $projectName = "quicktimeplayer" ] || [ $projectName = "quicktimeplayerx" ]; then
            rootPath="/tmp/QuickTimePlayerX_quicktimeplayerx.roots/Archives/Shared_QuickTimePlayerX_quicktimeplayerx_DSTROOT_osx.tar.gz"
        fi

	    sudo darwinup install "$rootPath"
    else
        echo "Error: Must provide a root to install"
    fi
}

function duinst {
	sudo darwinup uninstall "$1"
}

function dpop {
	sudo darwinup uninstall newest
}

currentBuildVersion=""
function _calculateCurrentBuildVersion {
    # Get product major/minor versions from sw_vers command
    productVersion=$(sw_vers | grep ProductVersion)
    productVersion="${productVersion##*:}"
    productVersion="$(echo $productVersion | tr -d '[:space:]')"

    # Get build version from sw_vers command
    buildVersion=$(sw_vers | grep BuildVersion)
    buildVersion="${buildVersion##*:}"
    buildVersion="$(echo $buildVersion | tr -d '[:space:]')"


    # Extract major/minor version for the product version string '10.15.1' -> {10, 15, 1}
    IFS='.'
    productVersionSplit=$productVersion
    read -ra productVersionSplit <<< "$productVersionSplit"
    majorVersionNumber="${productVersionSplit[1]}"
    minorVersionNumber="${productVersionSplit[2]}"

    # Convert majorVersionNumber to majorVersionString
    majorVersionString=""
    if [ "$majorVersionNumber" = "14" ]; then
        majorVersionString="Liberty"
    elif [ "$majorVersionNumber" = "15" ]; then
        majorVersionString="Jazz"
    elif [ "$majorVersionNumber" = "16" ]; then
        majorVersionString="Archer"
    fi

    # Convert minorVersionNumber to minorVersionString
    minorVersionString=""
    if [ "$minorVersionNumber" = "1" ]; then
        minorVersionString="A"
    elif [ "$minorVersionNumber" = "2" ]; then
        minorVersionString="B"
    elif [ "$minorVersionNumber" = "3" ]; then
        minorVersionString="C"
    elif [ "$minorVersionNumber" = "4" ]; then
        minorVersionString="D"
    elif [ "$minorVersionNumber" = "5" ]; then
        minorVersionString="E"
    elif [ "$minorVersionNumber" = "6" ]; then
        minorVersionString="F"
    elif [ "$minorVersionNumber" = "7" ]; then
        minorVersionString="G"
    fi

    # For debugging purposes
    #echo $buildVersion
    #echo $productVersion
    #echo $majorProductVersion
    #echo $minorProductVersion
    
    currentBuildVersion="macOS""$majorVersionString""$minorVersionString""$buildVersion"
}

function buildroot {
	currentRepoPath=$(git rev-parse --show-toplevel 2> /dev/null)

    projectName=""
    _calculateCurrentBuildVersion
    update=$currentBuildVersion
    sourcePath=$currentRepoPath


    # Grab input
	if [ -z "$currentRepoPath" ] || [ ! -z "$2" ]; then
        projectName="$1"

        if [ ! -z "$2" ]; then
           update="$2"
        fi
	else
        if [ ! -z "$1" ]; then
           update="$1"
        fi

        projectName="$(basename currentRepoPath)"
	fi

    # Set projectName to all lower case to make comparing easier
    projectName="$(echo "$projectName" | tr A-Z a-z)"


    # Validate projectName input against known projects (QuickTimePlayerX and AVKit)
    defaultProjectSourcePath=""
    if [ -z "$projectName" ]; then
        1>&2 echo "Error: Invalid project name or git repository. Use either AVKit or QuickTimePlayerX"
        return 0
    elif [ $projectName = "quicktime" ] || [ $projectName = "quicktimeplayer" ] || [ $projectName = "quicktimeplayerx" ] || [ $projectName = "qtpx" ]; then
        projectName="QuickTimePlayerX"

        defaultProjectSourcePath="/Users/adesjarlais/src/quicktimeplayerx"
    elif [ $projectName = "avkit" ]; then
        projectName="AVKit"

        defaultProjectSourcePath="/Users/adesjarlais/src/avkit"
    else
        1>&2 echo "Error: Invalid project name or git repository. Use either AVKit or QuickTimePlayerX"
        return 0
    fi

    # Validate update input
    comparatorUpdate="$(echo "$update" | tr A-Z a-z)"
    if [ $comparatorUpdate = "liberty" ]; then
        update="CurrentmacOSLiberty"
    elif [ $comparatorUpdate = "jazz" ]; then
        update="CurrentmacOSJazz"
    elif [ $comparatorUpdate = "archer" ]; then
        update="CurrentmacOSArcher"
    fi

    # Validate sourcePath input
    if [ -z "$sourcePath" ]; then
        sourcePath=$defaultProjectSourcePath
    fi


    sudo echo "Building root for $projectName against $update"
    sudo buildit -project $projectName -update $update -archive $sourcePath
}


############ Start up commands ######

start-emacs &> /dev/null


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

