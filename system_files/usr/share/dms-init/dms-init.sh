#!/bin/sh

set -euo pipefail

if [[ -e "$HOME/.config/dms-init/init" ]]; then
    exit 0
fi

mkdir -p $HOME/.config
cp -rvf /usr/share/dms-init/defaults/* $HOME/.config/

mkdir -p "$HOME/.config/dms-init"
touch "$HOME/.config/dms-init/init"
