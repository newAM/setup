#!/bin/bash
set -e

if code --version;
then
    echo "visual studio code is already installed"
else
    # https://code.visualstudio.com/docs/setup/linux#_installation
    sudo apt install apt-transport-https curl
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update
    sudo apt install -y code
fi

echo ""

# code --list-extensions
declare -a extensions=(
    Antyos.openscad
    ban.spellright
    be5invis.toml
    cssho.vscode-svgviewer
    dan-c-underwood.arm
    dtsvet.vscode-wasm
    esbenp.prettier-vscode
    lextudio.restructuredtext
    matklad.rust-analyzer
    monokai.theme-monokai-pro-vscode
    ms-azuretools.vscode-docker
    ms-python.python
    ms-python.vscode-pylance
    ms-toolsai.jupyter
    ms-vscode-remote.remote-ssh
    ms-vscode-remote.remote-ssh-edit
    ms-vscode.cmake-tools
    ms-vscode.cpptools
    ryanluker.vscode-coverage-gutters
    twxs.cmake
    usernamehw.errorlens
    webfreak.debug
    wmaurer.change-cas
)
for ext in "${extensions[@]}"; do
    code --install-extension "$ext"
done
