#!/bin/bash
set -e

url="https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb"
dropbox_dir="$HOME/Dropbox"

if [[ -d $dropbox_dir ]]
then
    echo "Dropbox directory exists at $dropbox_dir, assuming dropbox is already installed."
else
    sudo apt install -y python3-gpg
    wget "$url" -O /tmp/dropbox.deb
    sudo dpkg -i /tmp/dropbox.deb
    nautilus --quit
fi
rm /tmp/dropbox.deb 2> /dev/null || true
