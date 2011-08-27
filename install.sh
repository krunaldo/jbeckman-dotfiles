#!/bin/bash

cd dotfiles
find . -maxdepth 1 \
       \( -name .git \) -prune -o \
       \( -path . \) -o \
       -print0 | xargs -0 -I file cp -r file ~/   

cd $OLDPWD
for action in post-install/*; do
  $action
done
