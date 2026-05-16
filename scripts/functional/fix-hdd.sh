#!/bin/sh
sudo umount /dev/sdc1 
sudo ntfsfix /dev/sdc1 
sudo mount -t ntfs-3g -o remove_hiberfile /dev/sdc1 /mnt/HDD/ 
