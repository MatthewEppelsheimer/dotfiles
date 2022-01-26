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
  sudo apt install -qy git \
                       xclip \
                       net-tools \
                       inetutils-traceroute \
                       cmake \
                       jq \
                       wget \
                       apt-transport-https \
                       gnupg lsb-release

  # Install Node Version Manager
  # https://github.com/nvm-sh/nvm
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

  # Install Docker
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

  # install minikube
  # @see https://minikube.sigs.k8s.io/docs/start/
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/local/bin/minikube

  # install Trivy
  # @see https://aquasecurity.github.io/trivy/v0.22.0/getting-started/installation/
  sudo apt install -qy gnupg lsb-release
  wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
  echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
  sudo apt-get update # required again after adding a repository
  sudo apt-get install -qy trivy

  # configure Git
  git config --add core.editor vim # use Vim for commit message editing
  git config --global user.email "matthew.eppelsheimer@gmail.com"
  git config --global user.name "Matthew Eppelsheimer"

  # Install npm packages
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

