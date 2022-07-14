#!/bin/bash

# https://superuser.com/a/1330590
# https://askubuntu.com/questions/895634/old-ubuntu-core-snap-versions-are-filling-up-disk-space

snap list --all | awk '/disabled/{print $1, $3}' |
  while read snapname revision; do
    sudo snap remove "$snapname" --revision="$revision"
  done

