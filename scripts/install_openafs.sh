#!/bin/bash -e

pacaur --noconfirm --noedit -S openafs openafs-modules-dkms linux-headers dkms
sudo echo "cern.ch" | sudo tee /etc/openafs/ThisCell
sudo systemctl enable dkms
sudo systemctl start dkms
sudo systemctl enable openafs-client
sudo systemctl start openafs-client
