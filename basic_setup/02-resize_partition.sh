#!/bin/bash -e
sudo parted /dev/vda resizepart -- 1 Yes -0
sudo resize2fs /dev/vda1
