#!/bin/bash

set -ouex pipefail

### Install Cosmic Desktop
dnf5 install -y @cosmic-desktop-environment

dnf5 install -y papirus-icon-theme

systemctl enable podman.socket