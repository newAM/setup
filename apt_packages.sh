#!/bin/bash
set -e

sudo apt update
sudo apt install -y \
    ack-grep \
    build-essential \
    curl \
    fzf \
    git \
    htop \
    iotop \
    libclang-dev \
    libssl-dev \
    libusb-dev \
    pkg-config \
    rename \
    ripgrep \
    shellcheck
