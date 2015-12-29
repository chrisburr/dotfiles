#!/bin/bash -e

export PATH=~/miniconda/bin:$PATH
conda create -y --name jupyter python=3.5 anaconda ncurses
source activate jupyter
conda install -c cpcloud npm
npm install -g configurable-http-proxy
pip install jupyterhub

#
# Setup file permissions
#

# All all users to read the miniconda install direcotry
chmod -R o+r ~/miniconda
# Mark directories executable so they can be listed
chmod o+x ~/miniconda
find ~/miniconda -type d -exec chmod o+x {} \;
# Mark all miniconda related executables to be executable
find ~/miniconda -type f -executable -exec chmod o+x {} \;

#
# Make it so jupyterhub doesn't need to be ran as root
#
sudo useradd -m -r jupyterhub
# Add jupyterhub to the user's PATH using /etc/profile.d
sudo cp ../assets/profile_d/jupyterhub.sh /etc/profile.d/jupyterhub.sh
sudo chown --reference=/etc/profile.d/locale.sh /etc/profile.d/jupyterhub.sh
sudo chmod --reference=/etc/profile.d/locale.sh /etc/profile.d/jupyterhub.sh

# Install sudospawner so jupyterhub doesn't need to run as root
pip install git+https://github.com/jupyter/sudospawner

# Modify sudoers to allow jupyterhub to launch sudospawner as any user
sudo cp ../assets/sudoers_jupyterhub.txt /etc/sudoers.d/jupyterhub
sudo chown --reference=/etc/sudoers /etc/sudoers.d/jupyterhub
sudo chmod --reference=/etc/sudoers /etc/sudoers.d/jupyterhub
# Test
sudo -u jupyterhub sudo -n -u $USER sudospawner --help && echo "Sucessfully launched sudospawner"
sudo -u jupyterhub sudo -n -u $USER echo 'fail' && exit 1 || echo "Sucess sudo has been restricted"

# Allow access to the password database
sudo groupadd shadow
sudo chgrp shadow /etc/shadow
sudo chmod g+r /etc/shadow
sudo usermod -a -G shadow jupyterhub
# Test needs input and a password to be set
sudo -u jupyterhub python -c "import pamela, getpass; print(pamela.authenticate('$USER', getpass.getpass()))"

#
# Setup the jupyterhub config
#
sudo mkdir /etc/jupyterhub
sudo cp ../assets/jupyterhub_config.py /etc/jupyterhub/jupyterhub_config.py
sudo chown jupyterhub /etc/jupyterhub
sudo chown jupyterhub /etc/jupyterhub/jupyterhub_config.py
sudo chmod jupyterhub /etc/jupyterhub/jupyterhub_config.py

# TODO Install some shiny plugins and kernels

# Setup systemd services to start and expose the server
sudo cp ../systemctl/ssh_tunnel_jupyterhub.service /etc/systemd/system/
sudo chmod --reference=/etc/systemd/system/pacman-reanimation.service /etc/systemd/system/ssh_tunnel_jupyterhub.service
sudo chown --reference=/etc/systemd/system/pacman-reanimation.service /etc/systemd/system/ssh_tunnel_jupyterhub.service
sudo systemctl start ssh_tunnel_jupyterhub.service
sudo systemctl enable ssh_tunnel_jupyterhub.service
sudo cp ../systemctl/jupyterhub.service /etc/systemd/system/
sudo chmod --reference=/etc/systemd/system/pacman-reanimation.service /etc/systemd/system/jupyterhub.service
sudo chown --reference=/etc/systemd/system/pacman-reanimation.service /etc/systemd/system/jupyterhub.service
sudo systemctl start ssh_tunnel_jupyterhub.service
sudo systemctl enable ssh_tunnel_jupyterhub.service
