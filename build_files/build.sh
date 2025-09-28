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

### NVIDIA proprietary driver support

# Enable RPMFusion repos if not already enabled
dnf5 install -y \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Blacklist nouveau to avoid conflicts
echo "blacklist nouveau" > /etc/modprobe.d/blacklist-nouveau.conf
echo "options nouveau modeset=0" >> /etc/modprobe.d/blacklist-nouveau.conf

# Rebuild initramfs so nouveau is disabled
dracut --force

# Install NVIDIA drivers and tools
dnf5 install -y \
    akmod-nvidia \
    xorg-x11-drv-nvidia \
    xorg-x11-drv-nvidia-cuda \
    nvidia-settings \
    vulkan

# Ensure NVIDIA kernel modules build at boot
systemctl enable display-manager.service

### Optional: container support with Podman
dnf5 install -y podman
systemctl enable podman.socket

### Clean up package cache
dnf5 clean all