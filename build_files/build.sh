#!/bin/bash

set -ouex pipefail

### Install Cosmic Desktop
dnf5 install -y @cosmic-desktop-environment

### Enable CachyOS kernel COPR
dnf5 -y copr enable bieszczaders/kernel-cachyos

# Install CachyOS kernel and headers
dnf5 install -y kernel-cachyos kernel-cachyos-devel-matched


systemctl enable podman.socket