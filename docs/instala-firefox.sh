#!/bin/bash

# instala e configura o firefox
# contato telegram: @rocker_raccoon
# atualizado em: 09.11.2021

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
rm -rf $HOME/.local/lib/firefox ; rm -rf $HOME/.local/share/firefox ; rm -rf $HOME/.cache/firefox-setup
mkdir -p $HOME/.cache/firefox-setup ; cd $HOME/.cache/firefox-setup
wget https://archlinux.org/packages/extra/x86_64/firefox/download -O firefox.pkg.tar.zst
wget https://archlinux.org/packages/extra/x86_64/dbus-glib/download -O dbus-glib.pkg.tar.zst
for i in *.* ;do tar -I zstd -xvf "$i"; done
rm -f usr/lib/firefox/browser/features/{doh-rollout@mozilla.org.xpi,screenshots@mozilla.org.xpi,webcompat-reporter@mozilla.org.xpi,webcompat@mozilla.org.xpi}
mv usr/lib/firefox $HOME/.local/lib
ln -sf $HOME/.local/lib/firefox/firefox $HOME/.local/bin ; ln -sf $HOME/.local/lib/firefox/firefox $HOME/.local/bin/browser
mv usr/lib/libdbus-glib-1.so.2.3.5 $HOME/.local/lib/libdbus-glib-1.so.2
cat << EOF > $HOME/.local/share/applications/firefox.desktop
[Desktop Entry]
Version=1.0
Name=Firefox
Keywords=Internet;WWW;Browser;Web;Explorer;Explorador;Navegador
Exec=$HOME/.local/lib/firefox/firefox %u
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
Exec=$HOME/.local/lib/firefox/firefox --new-window %u

[Desktop Action new-private-window]
Name=New Private Window
Name[pt_BR]=Nova janela privativa
Exec=$HOME/.local/lib/firefox/firefox --private-window %u
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
rm -rf $HOME/.mozilla.backup >/dev/null 2>&1 ; mv $HOME/.mozilla $HOME/.mozilla.backup >/dev/null 2>&1
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
$HOME/.local/lib/firefox/firefox --private-window --profile "$HOME/.mozilla/firefox/anon"
exit
EOF
chmod +x $HOME/.local/bin/anon
cat << EOF > $HOME/.local/bin/"$USER"
#!/bin/bash
$HOME/.local/lib/firefox/firefox --profile "$HOME/.mozilla/firefox/$USER"
exit
EOF
chmod +x $HOME/.local/bin/"$USER"
fi
}

INSTALAR
CONFIGURAR

$HOME/.local/lib/firefox/firefox --setDefaultBrowser --ProfileManager

cd $HOME

exit
