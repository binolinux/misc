#!/bin/bash

# instala e configura o firefox
# contato telegram: @rocker_raccoon
# atualizado em: 28.11.2021

clear
killall firefox >/dev/null 2>&1
killall firefox-bin >/dev/null 2>&1
killall /usr/local/bin/firefox >/dev/null 2>&1
killall /usr/bin/firefox >/dev/null 2>&1
killall /opt/firefox/firefox >/dev/null 2>&1
LOCAL=`pwd`

INSTALAR() {
echo ; echo -n "Instalar o Firefox? [ S ou s = SIM ] " ; read RDK ; echo
if [[ $RDK = [sSyY] ]]; then
sudo rm -rf /opt/firefox ; rm -rf $HOME/.cache/firefox-setup
mkdir -p $HOME/.cache/firefox-setup ; cd $HOME/.cache/firefox-setup
wget https://archlinux.org/packages/extra/x86_64/firefox/download -O firefox.pkg.tar.zst
wget https://archlinux.org/packages/extra/any/firefox-i18n-pt-br/download -O firefox-ptbr.pkg.tar.zst
wget https://archlinux.org/packages/community/any/firefox-ublock-origin/download -O ublock.pkg.tar.zst
if [ ! -f /usr/local/lib/libdbus-glib-1.so.2 ]; then
wget https://archlinux.org/packages/extra/x86_64/dbus-glib/download -O dbus-glib.pkg.tar.zst
fi
for i in *.* ;do tar -I zstd -xvf "$i"; done
rm -f usr/lib/firefox/browser/features/{doh-rollout@mozilla.org.xpi,screenshots@mozilla.org.xpi,webcompat-reporter@mozilla.org.xpi,webcompat@mozilla.org.xpi}
sudo mv usr/lib/firefox /opt
sudo ln -sf /opt/firefox/firefox /usr/local/bin ; sudo ln -sf /opt/firefox/firefox /usr/local/bin/browser
sudo mv usr/lib/libdbus-glib-1.so.2.3.5 /usr/local/lib/libdbus-glib-1.so.2
cat << EOF > $HOME/.local/share/applications/firefox.desktop
[Desktop Entry]
Version=1.0
Name=Firefox
Keywords=Internet;WWW;Browser;Web;Explorer;Explorador;Navegador
Exec=/opt/firefox/firefox %u
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
Exec=/opt/firefox/firefox --new-window %u

[Desktop Action new-private-window]
Name=New Private Window
Name[pt_BR]=Nova janela privativa
Exec=/opt/firefox/firefox --private-window %u
EOF
chmod +x $HOME/.local/share/applications/firefox.desktop
rm -rf $HOME/.cache/firefox-setup
fi
}

CONFIGURAR(){
clear ; echo ; echo -n "Configurar o Firefox? [ S ou s = SIM ] " ; read RDK ; echo
if [[ $RDK = [sSyY] ]]; then
cd "$LOCAL"
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

if [ -f /opt/firefox/firefox ]; then
sudo ln -sf /opt/firefox/firefox /usr/local/bin
sudo ln -sf /opt/firefox/firefox /usr/local/bin/browser
`which firefox` --setDefaultBrowser --ProfileManager
fi

fi
}

INSTALAR
CONFIGURAR

cd $HOME

exit
