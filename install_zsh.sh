#!/bin/bash
set -e

sudo apt install -y curl fzf git zsh

omz="$HOME/.oh-my-zsh"
if [[ -d $omz ]]
then
    echo "oh-my-zsh already installed at $omz"
else
    git clone https://github.com/ohmyzsh/ohmyzsh.git "$omz"
fi

zshrc="$HOME/.zshrc"
if [[ -f $zshrc ]]
then
    echo "$zshrc already exists"
else
    curl -fLo "$zshrc" \
        https://raw.githubusercontent.com/newAM/dotfiles/master/.zshrc
fi

install_plugin() {
    local plugin_dir="$omz/custom/plugins/$1"
    if [[ -d $plugin_dir ]]
    then
        echo "$1 is already installed"
    else
        echo "installing $1..."
        git clone "https://github.com/zsh-users/$1" "$plugin_dir"
        echo "done installing $1"
        echo ""
    fi
}

install_plugin zsh-autosuggestions
install_plugin zsh-syntax-highlighting

echo "run 'chsh -s `which zsh`' to change the default shell"
