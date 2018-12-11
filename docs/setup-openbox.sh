#!/bin/bash
# configuracoes
export nnu="usuario" 	# 	<<< NOME DO USUARIO >>>
export grb="sda" 				# 	<<< UNIDADE ONDE INSTALARA O GRUB >>>
export hst="artix" 			# 	<<< HOSTNAME >>>

# linguagem / regiao / horario
echo -e 'pt_BR.UTF-8 UTF-8\npt_BR ISO-8859-1' | tee /etc/locale.gen ; echo "LANG=pt_BR.UTF-8" > /etc/locale.conf ; locale-gen ; export LANG=pt_BR.UTF-8 ; ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

echo $hst > /etc/hostname

# update dos mirrors do arch linux
rm -f /etc/pacman.d/.mirrorlist-arch ; curl -s "https://www.archlinux.org/mirrorlist/?country=BR&protocol=http&protocol=https&ip_version=4&ip_version=6&use_mirror_status=on" | tee /etc/pacman.d/mirrorlist-arch ; sed -i 's/#Server = /Server = /g' /etc/pacman.d/mirrorlist-arch ; clear ; pacman -Syy

# openbox + aplicativos
pacman -S --noconfirm --needed xorg-server xorg-xinit xorg-xrandr xorg-xkill ntfs-3g exfat-utils dosfstools linux-headers unrar wget git p7zip grub udiskie zsh networkmanager-runit dhcpcd-runit dbus-runit cgmanager-runit dhclient network-manager-applet systemd-dummy libsystemd-dummy alsa-utils rsync xdg-user-dirs xdg-utils openbox lxappearance lxappearance-obconf tint2 volumeicon arandr gsimplecal flameshot compton file-roller feh gnome-disk-utility nemo nemo-fileroller cinnamon-translations sakura geany gtk-engines gtk-engine-murrine htop wmctrl gparted neofetch polkit-gnome galculator gmrun jgmenu lxmenu-data transmission-gtk firefox-i18n-pt-br smplayer mpv lxdm-runit
ln -sf /usr/bin/sakura /usr/bin/xterm ; ln -sf /usr/bin/sakura /usr/bin/gnome-terminal
mkdir -p /etc/skel/.config/ ; cp -R /etc/xdg/openbox /etc/skel/.config/

# fix firefox
pacman -S --noconfirm --needed apulse patchelf ; patchelf --set-rpath /usr/lib/apulse /usr/lib/firefox/libxul.so

# senha do root
echo -e "artix\nartix" | passwd

# modificações no sudoers
sed -i '/%wheel ALL=(ALL) ALL/s/^#//' /etc/sudoers

# oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh /etc/skel/.oh-my-zsh ; cp /etc/skel/.oh-my-zsh/templates/zshrc.zsh-template /etc/skel/.zshrc

# usuario
useradd -m -g users -G wheel,storage,power -s /bin/bash $nnu ; sleep 1 ; echo -e "artix\nartix" | passwd $nnu ; chsh -s /bin/zsh $nnu

# instala o grub
grub-install --recheck /dev/$grb ; cp /etc/default/grub /etc/default/.grub ; sed -i 's/"quiet"/"quiet loglevel=0 splash"/' /etc/default/grub ; grub-mkconfig -o /boot/grub/grub.cfg

# ativa servicos
mkdir -p /run/runit ; ln -sf /etc/runit/runsvdir/current /run/runit/service ; ln -s /etc/runit/sv/NetworkManager /run/runit/service ; ln -s /etc/runit/sv/dhcpcd /run/runit/service ; ln -s /etc/runit/sv/cgmanager /run/runit/service ; ln -s /etc/runit/sv/lxdm /run/runit/service/

exit

