#!/bin/bash

set -ouex pipefail

### Update base system
dnf5 -y update

### Install core utilities
dnf5 install -y \
    tmux \
    vim \
    wget \
    curl \
    git \
    htop \
    bash-completion

### Install Cosmic Desktop
dnf5 install -y @cosmic-desktop-environment

# Enable graphical target and display manager
systemctl set-default graphical.target
systemctl enable display-manager.service

### Enable CachyOS kernel COPR
dnf5 -y copr enable bieszczaders/kernel-cachyos

# Install CachyOS kernel and headers
dnf5 install -y kernel-cachyos kernel-cachyos-devel-matched

### Optional: container support with Podman
dnf5 install -y podman
systemctl enable podman.socket

### Clean up package cache
dnf5 clean all