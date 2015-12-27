#!/bin/bash -e

# pinentry requires libgtk-x11-2.0.so.0 which is provided by gtk2
pacaur --noconfirm --noedit -S lastpass-cli xclip gtk2
lpass login $(echo Y2hyaXNidXJyNzNAZ29vZ2xlbWFpbC5jb20K | base64 --decode)
