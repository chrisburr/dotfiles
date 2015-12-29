#!/bin/bash -e
cd basic_setup
./01-install_packages.sh
./02-resize_partition.sh
./03-install_pacaur.sh
./04-install_lastpass.sh
./05-install_conda.sh
./06-install_oh_my_zsh.sh
./07-install_dotfiles.sh

cd ../additional_setup
./01a-install_openafs.sh
./01b-setup_keytab.exp cburr $(lpass show --password cern.ch)
./01c-keep_afs_credentials.sh
./02a-install_jupyter.sh
./03-install_nginx.sh
./04b-setup_iptables.sh
