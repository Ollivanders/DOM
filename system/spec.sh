#!/usr/bin/env bash
#
# Settings for both bash and zsh

# Stash your local environment variables in ~/.localrc. This means they'll stay out
# of your main dotfiles repository (which may be public, like this one), but
# you'll have access to them in your scripts.
# alernatively use the local.bzsh and local/ naming schems if you wish
# to be more organised and keep suttf in one placce 
if [[ -a ~/.localrc ]]; then
  source ~/.localrc
fi

# all of our zsh and bash files
config_files=($DOTFILES/**/*.bzsh)

for file in "${config_files[@]}"; do
  source $file
done


function add_dir_to_path() {
  # add subdirectories from bin to path
  for directory in $(find "$1" -mindepth 1 -type d); do
    if [ -d "$directory" ]; then
      PATH=$PATH:$directory
      add_dir_to_path $directory
    fi
  done
  # symlink directories too
  for directory in $(find "$1" -mindepth 1 -type l); do
    if [ -d "$directory" ]; then
      PATH=$PATH:$directory
      add_dir_to_path $directory
    fi
  done
}

add_dir_to_path "$DOTFILES/bin"