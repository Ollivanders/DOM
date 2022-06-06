#!/bin/bash
#
# install pip packages and symlink to config directory


if [ -z ${DOTFILES+x} ]; then
    source script/general.sh
else
    source ${DOTFILES}/script/general.sh
fi

# pip install flake8
# pip install wemake-python-styleguide

overwrite_all=true backup_all=false skip_all=false
PYTHON_CONFIG="${DOTFILES}/python/config"
for src in $(find -H $PYTHON_CONFIG -maxdepth 2 -type f); do
    # echo $src
    rel_config_path=${src#"$PYTHON_CONFIG"}
    dst="$HOME/.config${rel_config_path}"
    mkdir -p "${dst%/*}"
    # echo $dst
    link_file "$src" "$dst"
done