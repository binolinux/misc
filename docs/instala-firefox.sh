#!/bin/bash

# instala e configura o firefox
# contato telegram: @rocker_raccoon
# atualizado em: 10.12.2021

clear
killall firefox >/dev/null 2>&1
killall firefox-bin >/dev/null 2>&1
LOCAL=`pwd`

INSTALAR() {
echo ; echo -n "Instalar o Firefox? [ S ou s = SIM ] " ; read RDK ; echo
if [[ $RDK = [sSyY] ]]; then
sudo pacman -Syudd --needed --noconfirm firefox dbus-glib
mkdir -p $HOME/.cache/firefox-setup ; cd $HOME/.cache/firefox-setup
wget https://archlinux.org/packages/extra/any/firefox-i18n-pt-br/download -O firefox-ptbr.pkg.tar.zst
wget https://archlinux.org/packages/community/any/firefox-ublock-origin/download -O ublock.pkg.tar.zst
for i in *.* ;do tar -I zstd -xvf "$i"; done
sudo rm -f /usr/lib/firefox/browser/features/{doh-rollout@mozilla.org.xpi,screenshots@mozilla.org.xpi,webcompat-reporter@mozilla.org.xpi,webcompat@mozilla.org.xpi}
sudo cp -ar usr/lib/firefox/browser/extensions /usr/lib/firefox/browser
sudo ln -sf /usr/lib/firefox/firefox /usr/local/bin/browser
sudo rm -f /usr/share/applications/firefox.desktop
cat << EOF > $HOME/.local/share/applications/firefox.desktop
[Desktop Entry]
Version=1.0
Name=Firefox
Keywords=Internet;WWW;Browser;Web;Explorer;Explorador;Navegador
Exec=/usr/lib/firefox %u
Icon=firefox
Terminal=false
X-MultipleArgs=false
Type=Application
MimeType=text/html;text/xml;application/xhtml+xml;x-scheme-handler/http;x-scheme-handler/https;application/x-xpinstall;application/pdf;application/json;
StartupNotify=true
StartupWMClass=firefox
Categories=Network;WebBrowser;
Actions=new-window;new-private-window;

[Desktop Action new-window]
Name=New Window
Name[pt_BR]=Nova janela
Exec=/usr/lib/firefox --new-window %u

[Desktop Action new-private-window]
Name=New Private Window
Name[pt_BR]=Nova janela privativa
Exec=/usr/lib/firefox --private-window %u
EOF
chmod +x $HOME/.local/share/applications/firefox.desktop
rm -rf $HOME/.cache/firefox-setup
fi
}

CONFIGURAR(){
clear ; echo ; echo -n "Configurar o Firefox? [ S ou s = SIM ] " ; read RDK ; echo
if [[ $RDK = [sSyY] ]]; then
cd "$LOCAL"
mkdir -p "$LOCAL"/perfil/extensions
wget --content-disposition https://addons.mozilla.org/firefox/downloads/file/3869267 -O "$LOCAL"/perfil/extensions/browsec@browsec.com.xpi
echo 'user_pref("browser.download.dir", "'$HOME'/.cache");' >> "$LOCAL"/perfil/prefs.js
echo 'user_pref("browser.download.dir", "'$HOME'/.cache");' >> "$LOCAL"/anon/prefs.js
rm -rf $HOME/.mozilla/extensions >/dev/null 2>&1 ; rm -rf $HOME/.mozilla/firefox-backup >/dev/null 2>&1
mv $HOME/.mozilla/firefox $HOME/.mozilla/firefox-backup >/dev/null 2>&1
mkdir -p $HOME/.local/bin $HOME/.mozilla/firefox/{"$USER",anon}
cp -rT "$LOCAL"/perfil/ $HOME/.mozilla/firefox/"$USER"/
cp -rT "$LOCAL"/perfil/ $HOME/.mozilla/firefox/anon/
cp -rT "$LOCAL"/anon/ $HOME/.mozilla/firefox/anon/
rm -rf $HOME/.mozilla/firefox/anon/chrome
cat << EOF > $HOME/.mozilla/firefox/installs.ini
[6AFDA46A1A8AD48]
Default=$USER
Locked=0
EOF
cat << EOF > $HOME/.mozilla/firefox/profiles.ini
[Profile1]
Name=anon
IsRelative=1
Path=anon

[Profile0]
Name=$USER
IsRelative=1
Path=$USER
Default=1

[General]
StartWithLastProfile=1
Version=2

[Install6AFDA46A1A8AD48]
Default=$USER
Locked=1
EOF
cat << EOF > $HOME/.local/bin/anon
#!/bin/bash
firefox --private-window --profile "$HOME/.mozilla/firefox/anon"
exit
EOF
cat << EOF > $HOME/.local/bin/"$USER"
#!/bin/bash
firefox --profile "$HOME/.mozilla/firefox/$USER"
exit
EOF
chmod +x $HOME/.local/bin/{anon,"$USER"}

fi
}

INSTALAR
CONFIGURAR

cd $HOME

exit
