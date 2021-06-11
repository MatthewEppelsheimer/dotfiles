#!/usr/bin/env bash

function mle_uninstall_util_lns() {
  sudo rm /usr/local/bin/lns
}

function mle_uninstall_dotfiles() {
  rm ~/.bash_profile
  rm ~/.vimrc
}

