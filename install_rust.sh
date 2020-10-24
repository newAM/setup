#!/bin/bash
set -e

if rustup --version;
then
    echo "rustup is already installed"
    rustup self update
    rustup update
else
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    # shellcheck disable=SC1090
    source "$HOME/.cargo/env"
fi

echo ""

declare -a components=(
    llvm-tools-preview
)

for component in "${components[@]}"; do
    rustup component add "$component"
done

echo ""

declare -a crates=(
    bandwhich
    bat
    bindgen
    cargo-binutils
    cargo-deadlinks
    cargo-readme
    cargo-spellcheck
    cargo-tarpaulin
    debcargo
    du-dust
    exa
    gitoxide
    gitui
    just
    tealdeer
    ytop
)

for crate in "${crates[@]}"; do
    cargo install "$crate"
done

cargo install tokei --features all
