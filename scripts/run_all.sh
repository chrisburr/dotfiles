#!/bin/bash -e

./install_packages.sh
./install_pacaur.sh
./install_lastpass.sh
./install_openafs.sh
./setup_keytab.exp cburr $(lpass show --password cern.ch)
./install_keep_afs_credentials.sh
./install_conda.sh
./install_oh_my_zsh.sh
./install_dotfiles.sh
