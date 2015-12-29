#!/bin/bash -e

# Run gpg to make the config directory then enable auto-key-retrieve
gpg --list-keys
cp ../assets/gpg.conf ~/.gnupg/gpg.conf

# Install pacaur
[ -d ~/Downloads ] || mkdir ~/Downloads

git clone https://aur.archlinux.org/cower.git ~/Downloads/cower
cd ~/Downloads/cower
makepkg --noconfirm -sri

git clone https://aur.archlinux.org/pacaur.git ~/Downloads/pacaur
cd ~/Downloads/pacaur
makepkg --noconfirm -sri
