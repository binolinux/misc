#!/bin/bash

# Autologin SystemD

cat << EOF > /tmp/autologin@.service
[Unit]
Description=Getty on %I
Documentation=man:agetty(8) man:systemd-getty-generator(8)
Documentation=http://0pointer.de/blog/projects/serial-console.html
After=systemd-user-sessions.service plymouth-quit-wait.service getty-pre.target
Before=getty.target
IgnoreOnIsolate=yes
Conflicts=rescue.service
Before=rescue.service
ConditionPathExists=/dev/tty0

[Service]
ExecStart=-/sbin/agetty --noclear -a zzzz %I 38400 linux
Type=idle
Restart=always
RestartSec=0
UtmpIdentifier=%I
TTYPath=/dev/%I
TTYReset=yes
TTYVHangup=yes
TTYVTDisallocate=yes
KillMode=process
IgnoreSIGPIPE=no
SendSIGHUP=yes

UnsetEnvironment=LANG LANGUAGE LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT LC_IDENTIFICATION

[Install]
WantedBy=getty.target
DefaultInstance=tty1
EOF

sed -i "s/zzzz/$nnu/" /tmp/autologin@.service
sudo chmod 755 /tmp/autologin@.service ; sudo chown root:root /tmp/autologin@.service
sudo mkdir -p /usr/lib/systemd/system/ ; sudo mv /tmp/autologin@.service /usr/lib/systemd/system/
sudo systemctl enable autologin@tty1 ; sudo systemctl disable -f {getty@tty1,lxdm,lightdm,slim,sddm,gdm}

exit
