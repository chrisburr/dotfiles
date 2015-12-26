#!/bin/bash -e

sudo pacman --noconfirm -Syy
sudo pacman --noconfirm -Syu

sudo pacman --noconfirm -S base-devel zsh git expect wget tmux svn mosh
