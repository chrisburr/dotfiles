#!/bin/bash -e

pacaur --noconfirm --noedit -S openafs openafs-modules-dkms linux-headers dkms
sudo systemctl start enable
sudo systemctl start dkms
sudo systemctl enable openafs-client
sudo systemctl start openafs-client