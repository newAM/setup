#!/bin/bash
set -e

dropbox_dir="$HOME/Dropbox"
db_dir="$HOME/db"
if [[ -d $dropbox_dir ]]
then
    echo "Creating symlink $db_dir to $dropbox_dir"
    ln -s "$dropbox_dir" "$db_dir"
else
    echo "Dropbox directory is missing"
    exit 1
fi
