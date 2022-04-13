#
#
# ALIASES
#
#

## Saoirse CLI
alias s="saoirse"

## Misc #

### defaults
alias ls="ls -1Al --color=always"

### usage: jest-debug <path-to-test-file>
alias jest-debug="node --inspect=9229 $(which jest) --runInBand"

### File directory navigation
alias open='xdg-open' # Open file/URL path with preferred application

### Edit dotfiles
alias bash-config="vim ~/.bash_profile"
alias vim-config="vim ~/.vimrc"
alias bash-reload="source ~/.bash_profile"
alias bash-source="bash-reload"
alias setup-config="vim ~/dotfiles/TEMP_sigourney.sh"
# https://stackpointer.io/internet/decode-pem-encoded-ssl-certificate/523/
alias pem-cat="openssl x509 -text -noout -in"

### Python/venv
# See https://docs.python.org/3/tutorial/venv.html
alias venv-start="source ~/.venv/bin/activate"
alias venv-stop="deactivate"


## Turbine Aliases #

alias nifo="npm run nifo"

## Docker Aliases ##

alias dockc="docker-compose"
alias dockcd="docker-compose down"
alias dockcs="docker-compose stop"
alias dockcu="docker-compose up -d"
alias dockcps="docker-compose ps"
alias dockce="docker-compose exec"
alias docker-nifo="docker-armageddon"

## Nexus Aliases ##

alias nexus-login="docker login nexus.swimlane.io:5000"

## Podman Aliases ##

alias podc="podman-compose"

## Git Aliases #

alias add="git add -i"
alias branch="git branch"
alias checkout="git checkout"
alias commit="git commit"
alias cnv="git commit --no-verify"
alias commit-unsafe="HUSKY_SKIP_HOOKS=1 git commit"
alias diff="git diff"
alias fetch="git fetch"
alias merge="git merge"
alias pull="git pull"
alias push="git push"
alias restore="git restore"
alias stash="git stash"
alias wow="git status"

### rebasing #
alias fixup="git rebase -i HEAD~2"
alias rebase="git rebase -i"
alias rebase-ni="git rebase"

# Ubuntu Aliases #

alias gnome-restart="killall -9 gnome-shell"
alias gnome-reload="gnome-restart"

# ScreenConnect / ConnectWise Aliases #

alias sc-disable="sudo systemctl disable connectwisecontrol-4121fbe4ec6b5a36" # will prevent a restart, but won't stop if already started
alias sc-enable="sudo systemctl enable connectwisecontrol-4121fbe4ec6b5a36"
alias sc-start="sudo systemctl start connectwisecontrol-4121fbe4ec6b5a36"
alias sc-status="sudo systemctl list-units --all connectwisecontrol*"
alias sc-stop="sudo systemctl stop connectwisecontrol*"

## Kubernetes Aliases ##

alias k="kubectl"

## Barrier Aliases ##

alias barrierc="barrier.barrierc"
alias barriers="barrier.barriers"

## Resilio Sync Aliases ##

# Repair permissions so notes are accessible on Sigourney
alias note-perms-fix="sudo chown -R matthew.eppelsheimer:matthew.eppelsheimer ~/Documents/Notes"

## VPN Aliases ##

alias vpnStatusFull='sudo systemctl status openvpn-client@swimlane'
alias vpnStatus='vpnStatusFull | grep Active'
alias vpnUp='sudo systemctl start openvpn-client@swimlane; vpnStatus'
alias vpnDown='sudo systemctl stop openvpn-client@swimlane'


#
# SHORTCUTS
#
#

## Git shortcuts #

# Push a branch and set local to track the new upstream
function push-track {
    git push --set-upstream origin $(git branch --show-current)
}

## Docker shortcuts #

function docker-removecontainers {
    docker stop $(docker ps -aq)
    docker rm $(docker ps -aq)
}

function docker-removevolumes {
    docker volume rm $(docker volume ls --filter dangling=true -q)
}

function docker-armageddon {
    docker-removecontainers
    docker network prune -f
    docker-removevolumes
    docker rmi -f $(docker images --filter dangling=true -qa)
    docker rmi -f $(docker images -qa)
}

## Misc Utility shortcuts ##

# Add an "alert" alias for long running commands.  Use like so: `sleep 10; alert`
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


#
# INSTALL TOOLS
#
#

## Node Version Manager

# https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Symlink to current version on `nvm use`, useful for IDEs
export NVM_SYMLINK_CURRENT=true

## kubectl autocompletion

source <(kubectl completion bash)

#
# TURBINE LOCAL DEVELOMPENT
#
#

export cypress_username="matthew" 
export cypress_password="peanut butter"

# NOTE THESE ARE BROKEN. `npm run start` from turbine-ui runs in foreground.
alias turbine-cypress-gui="cd ~/dev/turbine && docker-compose up -d && cd packages/turbine-ui && npm run start && cd ../turbine-e2e && npx cypress open"
alias turbine-cypress="cd ~/dev/turbine && docker-compose up -d && cd packages/turbine-ui && npm run start && cd ../turbine-e2e && npx cypress run"
alias nifo="npm run nifo"


### COPIED FROM system's .bashrc; incorporate these in!

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# python get-pip.py puts things here
PATH="/home/matthew.eppelsheimer/.local/bin:$PATH"

