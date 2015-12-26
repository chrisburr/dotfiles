#!/bin/bash -e
cp ../systemctl/keep_afs_token.* ~/.config/systemd/user/
sed -i 's/{username}/cburr/g' ~/.config/systemd/user/keep_afs_token.service
systemctl --user start keep_afs_token.timer
systemctl --user enable keep_afs_token.timer
