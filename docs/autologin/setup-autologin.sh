#!/bin/bash

# Autologin SystemD

wget 'https://github.com/binolinux/misc/raw/master/docs/autologin/autologin%40.service' -O autologin@.service
export nnu=`whoami` ; sed -i "s/zzzz/$nnu/" ./autologin@.service
sudo chmod 755 ./autologin@.service ; sudo chown root:root ./autologin@.service
sudo mkdir -p /usr/lib/systemd/system/ ; sudo mv ./autologin@.service /usr/lib/systemd/system/
sudo systemctl enable autologin@tty1 ; sudo systemctl disable -f {getty@tty1,lxdm,lightdm,slim,sddm,gdm}

exit
