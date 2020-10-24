#!/bin/bash
set -e

sudo apt update
sudo apt install -y \
    ack-grep \
    fzf \
    git \
    htop \
    iotop \
    libssl-dev \
    libusb-dev \
    pkg-config \
    rename \
    ripgrep \
    shellcheck
