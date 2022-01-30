#!/usr/bin/env bash

function mle_install_util_lns() {
  chmod 751 ~/dotfiles/vendors/lns
  sudo ln -s ~/dotfiles/vendors/lns /usr/local/bin/lns
}

function mle_install_dotfiles() {
  lns ~/dotfiles/src/.bash_profile ~/.bash_profile
  lns ~/dotfiles/src/.vimrc ~/.vimrc
  sudo lns ~/dotfiles/src/user.conf /etc/sysctl.d/user.conf
}

function mle_postinstall_dotfiles() {
  echo "Now type 'source ~/.bash_profile'."
}

