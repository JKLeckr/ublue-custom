#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
#dnf5 install -y tmux

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

#systemctl enable podman.socket


# Remove unneeded packages

dnf5 remove -y firefox

# Install basic packages

dnf5 install -y tmux vim

## Setup DMS

dnf5 -y install dnf-plugins-core

dnf5 -y copr enable avengemedia/dms
dnf5 -y copr enable avengemedia/danklinux
dnf5 -y copr enable yalter/niri

# Add Packages:

dnf5 install -y libwayland-server

dnf5 install -y git xdg-desktop-portal-gtk accountsservice xwayland-satellite

dnf5 install -y xdg-user-dirs-gtk

dnf5 install -y --setopt=install_weak_deps=False niri
dnf5 install -y dms dms-greeter matugen quickshell danksearch ghostty
dnf5 install -y dankcalendar-git

dnf5 install -y tuned-ppd cups-pk-helper kf6-kimageformats i2c-tools khal adw-gtk3-theme fprintd

systemctl --global enable dms-init.service
systemctl --global add-wants niri.service dms.service
systemctl --global enable dsearch.service
systemctl enable greetd.service

## Install Apps
dnf5 install -y nautilus nautilus-python

dnf5 install -y gnome-text-editor

dnf5 install -y firefox

## Set up flatpak

## Additional setup

glib-compile-schemas /usr/share/glib-2.0/schemas/

## Cleanup
dnf5 clean -y all
