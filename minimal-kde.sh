#!/bin/sh

# Exit on error
set -e

echo "==> Updating system..."
apk update && apk upgrade

echo "==> Installing essential packages..."
apk add \
  dbus \
  elogind \
  xorg-server \
  plasma-desktop \
  konsole \
  dolphin \
  sddm \
  xinit \
  kde-cli-tools \
  plasma-nm \
  networkmanager \
  networkmanager-wifi \
  polkit-elogind \
  udisks2 \
  gvfs \
  xdg-utils \
  ttf-dejavu

# Optional: minimal system utilities
apk add \
  neofetch \
  htop \
  nano

echo "==> Enabling services..."
rc-update add dbus
rc-update add elogind
rc-update add sddm
rc-update add networkmanager
rc-service dbus start
rc-service elogind start
rc-service networkmanager start

echo "==> Setting SDDM as display manager..."
echo 'DISPLAYMANAGER="sddm"' > /etc/conf.d/xdm
rc-update add xdm

echo "==> KDE minimal installation complete."
echo "Reboot to enter KDE Plasma."