#!/bin/bash
mkdir /mnt/sda1
mount /dev/sda1 /mnt/sda1
mkswap /mnt/sda1/pupswap.swp
swapon /mnt/sda1/pupswap.swp
