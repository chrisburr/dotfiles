#!/bin/bash -e

sudo pacman --noconfirm -Syy
sudo pacman --noconfirm -Syu

sudo pacman --noconfirm -S base-devel zsh git expect wget tmux svn mosh parted

sudo localectl set-locale LANG=en_GB.UTF-8
sudo sed -i 's/#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/g' /etc/locale.gen
sudo locale-gen
