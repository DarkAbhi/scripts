#!/usr/bin/env bash

# Script to setup My Arch Linux

#Update 
sudo pacman -Syyu

#Install basic/essential GNOME Desktop Environment & few packages
sudo pacman -S gdm gnome-shell nautilus gnome-terminal gnome-tweak-tool gnome-control-center xdg-user-dirs networkmanager gnome-keyring network-manager-applet gnome-backgrounds evince adobe-source-code-pro-fonts ttf-dejavu zsh vlc neofetch linux-headers dkms wireguard-tools lolcat git 

# Enable GDM to start
systemctl enable gdm

# Enable Network Manager to start
systemctl enable NetworkManager

# Setup Git

git config --global user.name "Abhishek AN"
git config --global user.email "darkabhi1520@gmail.com"
git config --global credential.helper cache

echo "All Done"
