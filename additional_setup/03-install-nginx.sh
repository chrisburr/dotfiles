#!/bin/bash -e
pacaur --noconfirm --noedit -S nginx

cp ../assets/nginx.conf nginx.conf
sudo chown --reference=/etc/nginx/nginx.conf nginx.conf
sudo chmod --reference=/etc/nginx/nginx.conf nginx.conf
sudo mv nginx.conf /etc/nginx/nginx.conf

sudo systemctl enable nginx.service
sudo systemctl start nginx.service
