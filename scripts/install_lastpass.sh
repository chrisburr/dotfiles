#!/bin/bash -e

pacaur --noconfirm --noedit -S lastpass-cli
lpass login $(echo Y2hyaXNidXJyNzNAZ29vZ2xlbWFpbC5jb20K | base64 --decode)
