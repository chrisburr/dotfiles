#!/bin/bash -e

pacaur --noconfirm --noedit -S openafs openafs-modules-dkms linux-headers dkms
sudo echo "cern.ch" | sudo tee /etc/openafs/ThisCell
cp ../assets/krb5.conf .
sudo chown --reference=/etc/krb5.conf krb5.conf
sudo chmod --reference=/etc/krb5.conf krb5.conf
sudo mv krb5.conf /etc/krb5.conf
sudo systemctl enable dkms
sudo systemctl start dkms
sudo systemctl enable openafs-client
sudo systemctl start openafs-client
