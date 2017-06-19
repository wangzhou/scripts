#!/bin/bash

#
# $1 file path
# $2 directory to put
#
# when we use ~/Downloads/openembedded_sys/fs.img as a rootfs for qemu.
# this scripte can help to put a file into fs.img
#

sudo kpartx -a ~/Downloads/openembedded_sys/fs.img
sudo mount /dev/mapper/loop0p2 /mnt
sudo cp $1 /mnt$2
sudo umount /mnt
