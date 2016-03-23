# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#echo $TERM
#xterm

#source /etc/profile

export SERVER_ID=`hostname | sed -r 's/SERVER//g'`
export SERVER=`hostname`
export ALIAS='.alias_s'$SERVER_ID
export J=/home/jail/home/serv
export HOME=$J/system_config
cd $HOME
export GIT_SERV_HOME=$HOME
export GIT_BD=$J/BD_Scripts
export SERV_HOME=$HOME/$SERVER
export SHELL_CONFIG=.bashrc
export ROOT=root
export ROOT_GRP=root
export IPY=/home/jail/home/serv/system_config/SERVER5/celery
export SSHFS=`which sshfs`

# setup quick folders for sharing among ubuntu cluster
for n in 1 2 4 5; do
    if [[ $n != $SERVER_ID ]]; then
	x=`printf "export SHARE%s=/Volumes/ub%s/home/ub%s" $n $n $n`
	eval $x
	x=`printf "export SHARE%s_SERVER=SERVER%s" $n $n`
	eval $x

	y=`printf "export SERV%s=/Volumes/ub%s/$J" $n $n`
	eval $y
	y=`printf "export SERV%s_SERVER=SERVER%s" $n $n`
	eval $y
    fi
done
if [[ $SERVER_ID != 3 ]]; then
    export SHARE3=/Volumes/mbp2/Users/admin
    export SHARE3_SERVER=SERVER3
fi


#export TERM=screen-256color
#export TERM=xterm-256color tmux
export TERM=xterm-color
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"
export LC_COLLATE="C"
export CLICOLOR=1
#export LS_OPTIONS='--color'
export GREP_OPTIONS='--color'
export HISTCONTROL=ignoredups:erasedups
export HISTTIMEFORMAT="%d/%m/%y %T  "
export HISTIGNORE='*sudo -S*'
export HISTSIZE=1000000
export HISTFILESIZE=10000000
shopt -s histappend
export PROMPT_COMMAND="echo \[\$(date +%H:%M:%S)\]\ "
#export PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
export EDITOR=emacs
export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'

# ---------------------------------------
# Git
export GIT_CONFIG=$HOME/.git/config
#export GIT_TRACE=$HOME/.git/trace_log.txt
#<<<<<-------------------------------<<<<

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
export color_prompt=yes
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

d=/etc/dircolors
test -r $d && eval "$(dircolors $d)"

#alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'
alias grep='grep -i --color=auto'
alias fgrep='fgrep -i --color=auto'
alias egrep='egrep -i --color=auto'

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

_home=$HOME
_dir=$_home/.completers
if [ -d $_dir ]; then
    for i in `env ls $_dir`; do
	. $_dir/$i
    done
fi

if [ -f $_home/.scripts/.alias_shared ]; then
    . $_home/.scripts/.alias_shared
fi
if [ -f $_home/.scripts/.alias_linux ]; then
    . $_home/.scripts/.alias_linux
fi

if [ -f $SERV_HOME/local_config/$ALIAS ]; then
    . $SERV_HOME/local_config/$ALIAS
fi

if [ "${CLIENT_HOST}" = "SERVER3" ]; then
    test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
fi
