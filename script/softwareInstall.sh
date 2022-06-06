#!/usr/bin/env bash
#
# Run all dotfiles installers.

set -e

cd "$(dirname $0)"/..

# find the installers and run them iteratively
find . -maxdepth 2 -name install.sh | while read installer; do
    echo "installing ${installer}"
    sh -c "${installer}"
done
