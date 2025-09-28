#!/bin/bash

set -ouex pipefail

### Install Cosmic Desktop
dnf5 install -y @cosmic-desktop-environment

systemctl enable podman.socket