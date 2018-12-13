#!/bin/bash

# Autologin SystemD

sudo mkdir -p /usr/lib/systemd/system/
sudo cp ./autologin@.service /usr/lib/systemd/system/
export nnu=`whoami`
sudo sed sed -i "s/zzzz/$nnu/" /usr/lib/systemd/system/autologin@.service
sudo systemctl enable autologin@tty1 ; sudo systemctl disable -f {getty@tty1,lxdm,lightdm,slim,sddm,gdm}
exit

