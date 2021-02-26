#!/bin/bash
set -e

sudo apt update
sudo apt install -y \
    build-essential \
    curl \
    fzf \
    git \
    htop \
    iotop \
    libclang-dev \
    libftdi1-dev \
    libssl-dev \
    libusb-1.0-0-dev \
    libusb-dev \
    netcat \
    pkg-config \
    rename \
    ripgrep \
    shellcheck
