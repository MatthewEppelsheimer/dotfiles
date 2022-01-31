#!/usr/bin/env bash

# NOTE: SAUSAGE BEING MADE HERE. A LOT OF THIS DOESN'T MAKE SENSE AND/OR WON'T RUN.
# 'Sigourney' is my primary workstation's name.

# Installation steps to configure Sigourney
#
# ###########

install_cli_tools () {
  sudo apt install -qy xclip \
                       net-tools \
                       inetutils-traceroute \
                       cmake \
                       jq \
                       wget \
                       apt-transport-https \
                       gnupg \
                       lsb-release
}

install_nvm () {
  # https://github.com/nvm-sh/nvm
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

  # make nvm command available for rest of script
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ]
  \. "$NVM_DIR/nvm.sh"
}

install_node () {
  nvm install node # latest
  nvm install 16 # for Platform
  nvm install 12 # for Turbine; as the last this'll also become current version
}

install_docker () {
  # Based on: https://docs.docker.com/engine/install/ubuntu/
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository -y \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"
  sudo apt install -qy docker-ce docker-ce-cli containerd.io

  # Install docker-compose
  sudo apt install -qy docker-compose

  # Run docker without root access
  # See https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user
  sudo groupadd docker
  sudo usermod -aG docker $USER
  # @TODO update this; file doesn't exist
  sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
  # @TODO update this; file doesn't exist
  sudo chmod g+rwx "$HOME/.docker" -R

  # configure Docker to start on boot
  sudo systemctl enable docker
}

install_minikube () {
  # @see https://minikube.sigs.k8s.io/docs/start/
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/local/bin/minikube
}

install_trivy () {
  # @see https://aquasecurity.github.io/trivy/v0.22.0/getting-started/installation/
  wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
  echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
  sudo apt-get update # required again after adding a repository
  sudo apt-get install -qy trivy
}

install_nest () {
  # @TODO broken; fix by adding npm to path
  npm i -g @nestjs/cli
  npm i -g @nestjs/core
}

install_resilio_sync () {
  # @see https://help.resilio.com/hc/en-us/articles/206178924-Installing-Sync-package-on-Linux
  echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | sudo tee /etc/apt/sources.list.d/resilio-sync.list
  curl -L https://linux-packages.resilio.com/resilio-sync/key.asc | sudo apt-key add
  sudo apt-get update
  sudo apt install -qy resilio-sync

  # run as current user
  sudo sed -i 's/WantedBy=multi-user.target/WantedBy=default.target/' /usr/lib/systemd/user/resilio-sync.service

  # Alternate to running under current user, run under `rslsync` user
  # add rslsync user to current user group
  # sudo usermod -aG matthew.eppelsheimer rslsync
  # sudo usermod -aG rslsync matthew.eppelsheimer

  # enable automatic startup
  sudo systemctl enable resilio-sync
}

sigourney_setup () {
  # Update apt cache
  sudo apt-get update

  install_cli_tools
  install_nvm
  install_node
  install_docker
  install_minikube
  install_trivy
  install_resilio_sync

  # configure Git
  git config --add core.editor vim # use Vim for commit message editing
  git config --global user.email "matthew.eppelsheimer@gmail.com"
  git config --global user.name "Matthew Eppelsheimer"

  # Install npm packages
  # @TODO broken; fix by adding npm to path
  npm install --global concurrently
  npm install --global nodemon
  npm install --global typescript@4.2.4 # match turbine

  # Install GUI applications that lack snaps
  sudo apt install -qy gnome-tweaks # app name: "Tweaks"

  # Install GUI applications that have snaps
  snap install bitwarden
  snap install bw # bitwarden CLI
  snap install darktable
  snap install firefox
  snap install postman
  snap install rider
  snap install slack
  snap install spotify --classic
  snap install webstorm --classic
  snap install helm --classic

  # Install proprietary media codecs
  # Ubuntu only packages open-source media codecs, which excludes e.g. MP3, AVI, MPEG4
  sudo apt install -qy ubuntu-restricted-extras

  # SOFTWARE INSTALLED WITHOUT PACKAGE MANAGERS
  #
  # - Obsidian https://github.com/obsidianmd/obsidian-releases/releases/download/v0.10.7/Obsidian-0.10.7.AppImage
  #     - https://forum.obsidian.md/t/how-to-install-obsidian-snap-on-ubuntu/2515: `sudo snap install --dangerous <file>`
  # - Anki https://apps.ankiweb.net/#linux
  # - Zoom
  #     - No snap, and apt isn't kept up to date. To upgrade: Open client > click avatar at top right > "Check for Updates"

  # Install manual dependencies for software installed without package managers
  # for Anki:
  sudo apt install -qy libxcb-xinerama0

  # Install various tools
  install_nest

  # Cleanup all now-orphaned dependencies
  sudo apt autoremove

  # Instruct user to restart
  # Required for the new "docker" usergroup to load globally
  # (`newgrp docker` only works in the local shell, and isn't what we want anyhow.)
  echo "RESTART THE SYSTEM MANUALLY FOR ALL SETUP CHANGES TO TAKE EFFECT"
}
sigourney_setup


# Bash Profile SUPER TEMP
#
# ###########

TEMP_sigourney_bash_profile () {
  # Run SSH agent in background
  eval "$(ssh-agent -s)"
}

# Free up disk space

sigourney_prune_logs () {
  sudo journalctl --rotate --vacuum-time=1m
}

sigourney_prune_snaps_disabled () {
  sudo sh /home/matthew.eppelsheimer/dotfiles/scripts/snap_prune_disabled.sh
}

