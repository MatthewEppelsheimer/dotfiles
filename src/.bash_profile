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

## Git Aliases #

alias add="git add -i"
alias branch="git branch"
alias checkout="git checkout"
alias commit="git commit"
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

function docker-armageddon {
    docker-removecontainers
    docker network prune -f
    docker rmi -f $(docker images --filter dangling=true -qa)
    docker volume rm $(docker volume ls --filter dangling=true -q)
    docker rmi -f $(docker images -qa)
}


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

export cypress_username="tester" 
export cypress_password="tester123 tester"

alias turbine-cypress-open="cd ~/dev/turbine && docker-compose up -d && cd packages/turbine-ui && npm run start && cd ../turbine-e2e && npx cypress open"
alias nifo="npm run nifo"


#
# Pyenv
#
#

PATH="/usr/local/src/pyenv/shims:$PATH"

