#!/usr/bin/env bash

function mle_install_util_lns() {
  chmod 751 ~/dotfiles/vendors/lns
  sudo ln -s ~/dotfiles/vendors/lns /usr/local/bin/lns
}

function mle_install_dotfiles() {
  lns ~/dotfiles/src/.bash_profile ~/.bash_profile
  lns ~/dotfiles/src/.vimrc ~/.vimrc
  sudo lns ~/dotfiles/src/user.conf /etc/sysctl.d/user.conf
  # apply changes in /etc/sysctl.d/user.conf
  sudo sysctl -p --system
}

function mle_install_scripts() {
  lns ~/dotfiles/scripts/firmware_update.sh ~/.local/bin/firmware-update
  lns ~/dotfiles/scripts/snap_prune_disabled.sh ~/.local/bin/snap-prune-disabled
}

function mle_postinstall_dotfiles() {
  echo "Now type 'source ~/.bash_profile'."
}

