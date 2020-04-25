#!/bin/bash
set -e

apt_install_if_not() {
    local pkg="${2:-$1}"
    if at=$(command -v $1);
    then
        echo "$pkg is already installed: $at"
    else
        echo "installing $pkg..."
        sudo apt install -y "$pkg"
        echo "done installing $pkg"
        echo ""
    fi
}

apt_install_if_not nvim neovim
apt_install_if_not git
apt_install_if_not curl
apt_install_if_not cmake
apt_install_if_not pip3 python3-pip

vim_plug="$HOME/.local/share/nvim/site/autoload/plug.vim"
if [[ -f $vim_plug ]]
then
    echo "vim-plug already installed"
else
    echo "installing vim-plug..."
    curl -fLo "$vim_plug" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "done installing vim-plug"
    echo ""
fi

nvim_config="$HOME/.config/nvim"
nvim_init="$nvim_config/init.vim"
if [[ -f $nvim_init ]]
then
    echo "init.vim already exists at $nvim_init"
else
    echo "downloading init.vim to $nvim_init"
    curl -fLo "$nvim_init" --create-dirs \
        https://raw.githubusercontent.com/newAM/dotfiles/master/.config/nvim/init.vim
fi

if python3 -m black --version
then
    echo "black already installed"
else
    echo "installing black..."
    sudo -H python3 -m pip install black
    echo "done installing black"
    echo ""
fi

echo "installing vim plugins..."
nvim +PlugInstall +qall

echo "building YouCompleteMe..."
sudo apt install -y build-essential python3.8-dev
python3.8 ~/.config/nvim/plugged/YouCompleteMe/install.py --rust-completer
