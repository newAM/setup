#!/bin/bash
set -e

sudo apt install -y tmux git curl

tpm_dir="$HOME/.tmux/plugins/tpm"
if [[ -d $tpm_dir ]]
then
    echo "tmux plugin manager already installed"
else
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
fi

tmux_conf="$HOME/.tmux.conf"
if [[ -f $tmux_conf ]]
then
    echo "$tmux_conf already exists"
else
    curl -fLo "$tmux_conf" \
        https://raw.githubusercontent.com/newAM/dotfiles/master/.tmux.conf
fi

export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins/"
"$tpm_dir/bin/install_plugins"
