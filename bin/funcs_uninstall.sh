#!/usr/bin/env bash

function mle_uninstall_util_lns() {
  sudo rm /usr/local/bin/lns
}

function mle_uninstall_dotfiles() {
  rm ~/.bash_profile
  rm ~/.vimrc
  sudo rm /etc/sysctl.d/user.conf
  # Apply config changes after removing /etc/sysctl.d/user.conf
  sudo sysctl -p --system
}

