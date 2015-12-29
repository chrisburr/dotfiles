#!/bin/bash -e
cd ~/Downloads
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda

export PATH="$HOME/miniconda/bin:$PATH"
conda create -y --name python-2.7 python=2.7 anaconda ncurses
conda create -y --name python-3.5 python=3.5 anaconda ncurses
