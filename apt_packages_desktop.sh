#!/bin/bash
set -e

sudo apt update
sudo add-apt-repository -y ppa:mmstick76/alacritty

sudo apt install -y \
    alacirtty \
    flameshot \
    fonts-powerline
