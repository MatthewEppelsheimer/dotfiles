#
# ALIASES
#
#

## Misc #

### usage: jest-debug <path-to-test-file>
alias jest-debug="node --inspect=9229 $(which jest) --runInBand"

### File directory navigation
alias open='xdg-open' # Open file/URL path with preferred application

### Edit dotfiles
alias bash-config="vim ~/.bash_profile"
alias vim-config="vim ~/.vimrc"
alias bash-reload="source ~/.bash_profile"
alias bash-source="bash-reload"
# https://stackpointer.io/internet/decode-pem-encoded-ssl-certificate/523/
alias pem-cat="openssl x509 -text -noout -in"

## Turbine Aliases #
alias nifo="npm run nifo"

# Docker Aliases #
alias dockc="docker-compose"
alias dockcd="docker-compose down"
alias dockcs="docker-compose stop"
alias dockcu="docker-compose up -d"
alias dockcps="docker-compose ps"
alias dockce="docker-compose exec"

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
alias rebase="git rebase -i"
alias rebase-ni="git rebase"
alias wow="git status"

## Kubernetes Aliases ##

alias k="kubectl"

## Barrier Aliases ##
alias barrierc="barrier.barrierc"
alias barriers="barrier.barriers"

#
# SHORTCUTS
#
#

## Git shortcuts #

# Push a branch and set local to track the new upstream
function push-track {
    git push --set-upstream origin $(git branch --show-current)
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

