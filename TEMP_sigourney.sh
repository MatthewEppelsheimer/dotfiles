#!/usr/bin/env bash

# NOTE: SAUSAGE BEING MADE HERE. A LOT OF THIS DOESN'T MAKE SENSE AND/OR WON'T RUN.
# 'Sigourney' is my primary workstation's name.

# Installation steps to configure Sigourney
#
# ###########

install_nest () {
  npm i -g @nestjs/cli
  npm i -g @nestjs/core
}

sigourney_setup () {
  # Update apt cache
  sudo apt-get update

  # Install command line tools
  sudo apt install git
  sudo apt-get install xclip

  # Install Node Version Manager
  # https://github.com/nvm-sh/nvm
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

  # Install Docker
  # Based on: https://docs.docker.com/engine/install/ubuntu/
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"
  sudo apt-get install docker-ce docker-ce-cli containerd.io

  # Install docker-compose
  sudo apt-get install docker-compose

  # Run docker without root access
  # See https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user
  sudo groupadd docker
  sudo usermod -aG docker $USER
  sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
  sudo chmod g+rwx "$HOME/.docker" -R

  # configure Docker to start on boot
  sudo systemctl enable docker

  # install minikube
  # @see https://minikube.sigs.k8s.io/docs/start/
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/local/bin/minikube

  # configure Git
  git config --add core.editor vim # use Vim for commit message editing

  # Install npm packages
  npm install --global concurrently
  npm install --global jest@^26.4.2 # match swimlane/turbine/packages/turbine-database version
  npm install --global lerna@~4.0.0 # match swimlane/turbine version
  npm install --global nodemon
  npm install --global tslint
  npm install --global typescript@4.0.3 # match swimlane/turbine (packages; root is different as of 2021-06-03)

  # Install GUI applications that lack snaps
  sudo apt install gitk
  sudo apt install gnome-tweak-tool # app name: "Tweak"

  # Install GUI applications that have snaps
  snap install barrier
  snap install bitwarden
  snap install bw # bitwarden CLI
  snap install code --classic # VS Code
  snap install darktable
  snap install firefox
  snap install signal-desktop
  snap install slack
  snap install spotify --classic
  snap install webstorm --classic

  # Apps installed manually
  #
  # - zoom -- No snap, and apt isn't kept up to date. To upgrade: Open client > click avatar at top right > "Check for Updates"


  # Install proprietary media codecs
  # Ubuntu only packages open-source media codecs, which excludes e.g. MP3, AVI, MPEG4
  sudo apt install ubuntu-restricted-extras

  # Cleanup all now-orphaned dependencies
  sudo apt autoremove


  # SOFTWARE INSTALLED WITHOUT PACKAGE MANAGERS
  #
  # - Obsidian https://github.com/obsidianmd/obsidian-releases/releases/download/v0.10.7/Obsidian-0.10.7.AppImage
  #     - https://forum.obsidian.md/t/how-to-install-obsidian-snap-on-ubuntu/2515: `sudo snap install --dangerous <file>`
  # - Anki https://apps.ankiweb.net/#linux

  # Install manual dependencies for software installed without package managers
  # for Anki:
  sudo apt install libxcb-xinerama0


  # Install various tools
  install_nest

  # Instruct user to restart
  # Required for the new "docker" usergroup to load globally
  # (`newgrp docker` only works in the local shell, and isn't what we want anyhow.)
  # @TODO would be nice to make this automatic after notifying user with a countdown from 5
  echo "RESTART THE SYSTEM MANUALLY FOR ALL SETUP CHANGES TO TAKE EFFECT"
}


# Bash Profile SUPER TEMP
#
# ###########

TEMP_sigourney_bash_profile () {
  # Run SSH agent in background
  eval "$(ssh-agent -s)"
}

# VS Code
#
# ##########

vscode_extensions_install () {
  # - documents
  #   - JSON Web Tokens (JWT)
  code --install-extension yokawasa.jwt-debugger
  #   - Markdown
  code --install-extension yzhang.markdown-all-in-one
  #
  # - features
  #   - file type icons
  code --install-extension vscode-icons-team.vscode-icons
  #   - Intellisense (with AI)
  code --install-extension visualstudioexptteam.vscodeintellicode
  #   - REST client
  code --install-extension humao.rest-client
  #
  # - frameworks
  #   - Angular
  code --install-extension angular.ng-template
  #
  # - languages
  #   - C/C++
  code --install-extension ms-vscode.cpptools
  code --install-extension austin.code-gnu-global # C++ Intellisense
  #   - python
  code --install-extension mys-python.python
  #   - TypeScript
  code --install-extension steoates.autoimport
  #
  # - tool integration
  #   - Docker
  code --install-extension ms-azuretools.vscode-docker
  #   - ESLint
  code --install-extension dbaeumer.vscode-eslint
  #   - git
  code --install-extension eamodio.gitlens
  code --install-extension donjayamannie.githistory
  #   - TSLint ---- NOTE DEPRECATED!
  code --install-extension ms-vscode.vscode-typescript-tslint-plugin
  #   - Prettier
  code --install-extension esbenp.prettier-vscode
}
# vscode_extensions_install

vscode_configure_system () {
	# Be sure max file watches increased!
	# @TODO version /etc/sysctl.conf
	# @see https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc
}
# vscode_configure_system

# part of daily sigourney-update
#
# ###########

sigourney_update () {
  # upgrade local package DB
  # @TODO add a flag for confirmation?
  sudo apt-get update
  
  # upgrade packages
  # @TODO add a flag for confirmation?
  sudo apt-get upgrade
}

