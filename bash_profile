pwdtail () { #returns the last 2 fields of the working directory
  pwd|awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}

#env vars
export PATH=$PATH:/usr/local/go/bin
export GOPATH=/users/gm/Documents/go

#my bashness
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad


#prompt
prompt_command () {
    if [ $? -eq 0 ]; then # set an error string for the prompt, if applicable
        ERRPROMPT=" "
    else
        ERRPROMPT='->($?) '
    fi
#    if [ "\$(type -t __git_ps1)" ]; then # if we're in a Git repo, show current branch
#        BRANCH="\$(__git_ps1 '[ %s ] ')"
#    fi
    local TIME=`fmt_time` # format time for prompt string
    local LOAD=`uptime|awk '{min=NF-2;print $min}'`
    local DKGREEN="\[\033[0;32m\]"
    local GREEN="\[\033[1;32m\]"
    local CYAN="\[\033[0;36m\]"
    local DKBLUE="\[\033[0;34m\]"
    local BCYAN="\[\033[1;36m\]"
    local DKBLUE="\[\033[0;34m\]"
    local BLUE="\[\033[1;34m\]"
    local GRAY="\[\033[0;37m\]"
    local DKGRAY="\[\033[1;30m\]"
    local WHITE="\[\033[1;37m\]"
    local RED="\[\033[1;31m\]"
    local DKRED="\[\033[0;31m\]"
    local PURPLE="\[\033[0;35m\]"
    local MAGENTA="\[\033[1;35m\]"
    local DKYELLOW="\[\033[0;33m\]"
    local YELLOW="\[\033[1;93m\]"
    # return color to Terminal setting for text color
    local DEFAULT="\[\033[0;39m\]"
    # set the titlebar to the last 2 fields of pwd
    local TITLEBAR='\[\e]2;`pwdtail`\a'
    #set PS1 prompt
    export PS1="\[${TITLEBAR}\]${DKGRAY}[${DKRED}[${RED}[${WHITE}[ ${YELLOW}\u${DKYELLOW}@${YELLOW}\
\h${DKYELLOW} (${LOAD}) ${YELLOW}${TIME} ${WHITE}]${RED}]${DKRED}]${DKGRAY}]${RED}$ERRPROMPT${WHITE}\
\w\n${GREEN}${BRANCH}${DEFAULT}$ "

}
PROMPT_COMMAND=prompt_command

fmt_time () { #format time just the way I likes it
    if [ `date +%p` = "PM" ]; then
        meridiem="pm"
    else
        meridiem="am"
    fi
    date +"%l:%M:%S$meridiem"|sed 's/ //g'
}
pwdtail () { #returns the last 2 fields of the working directory
    pwd|awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}
chkload () { #gets the current 1m avg CPU load
    local CURRLOAD=`uptime|awk '{print $8}'`
    if [ "$CURRLOAD" > "1" ]; then
        local OUTP="HIGH"
    elif [ "$CURRLOAD" < "1" ]; then
        local OUTP="NORMAL"
    else
        local OUTP="UNKNOWN"
    fi
    echo $CURRLOAD
}
PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/go/bin:/usr/local/go/bin
#PATH=/usr/local/opt/ruby193/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/go/bin:/usr/local/go/bin
export MSF_DATABASE_CONFIG=/usr/local/share/metasploit-framework/config/database.yml

#for reals
set -o vi

#my aliases
alias envme="vi ~/.bash_profile ; source ~/.bash_profile"

#force ssh password auth
alias sshpass="ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no $*"
alias scppass="scp -o PreferredAuthentications=password -o PubkeyAuthentication=no $*"
alias keyme="cat ~/.ssh/id_rsa.pub"

#docker machine env var setup
eval $(docker-machine env default)
