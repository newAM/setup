#!/bin/bash
set -e

if fc-list | grep -i powerline > /dev/null
then
    echo "powerline fonts already installed"
else
    sudo apt install -y git
    fonts_dir='/tmp/plfonts'
    mkdir -p "$fonts_dir"
    git clone --depth=1 https://github.com/powerline/fonts.git "$fonts_dir"
    "$fonts_dir/install.sh"
    rm -rf "$fonts_dir"
fi
