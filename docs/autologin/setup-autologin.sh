#!/bin/bash

# Autologin SystemD

export nnu=`whoami` ; sed -i "s/zzzz/$nnu/" ./autologin@.service
sudo mkdir -p /usr/lib/systemd/system/ ; sudo cp ./autologin@.service /usr/lib/systemd/system/
sudo systemctl enable autologin@tty1 ; sudo systemctl disable -f {getty@tty1,lxdm,lightdm,slim,sddm,gdm}
exit

