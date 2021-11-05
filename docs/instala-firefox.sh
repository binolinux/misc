#!/bin/bash

# instala e configura o firefox
# contato telegram: @rocker_raccoon
# atualizado em: 03.11.2021

clear
killall firefox >/dev/null 2>&1
killall firefox-bin >/dev/null 2>&1
killall /usr/local/bin/firefox >/dev/null 2>&1
killall /usr/bin/firefox >/dev/null 2>&1
killall /opt/firefox/firefox >/dev/null 2>&1

INSTALAR() {
echo ; echo -n "Instalar o Firefox? [ S ou s = SIM ] " ; read RDK ; echo
if [[ $RDK = [sSyY] ]]; then
sudo rm -rf $HOME/.cache/firefox >/dev/null 2>&1
sudo rm -rf /opt/firefox >/dev/null 2>&1
sudo rm -rf /tmp/firefox >/dev/null 2>&1
mkdir -p $HOME/.cache/firefox ; cd $HOME/.cache/firefox
wget https://archlinux.org/packages/extra/x86_64/firefox/download -O firefox.pkg.tar.zst
tar -I zstd -xvf firefox.pkg.tar.zst
rm -f usr/lib/firefox/browser/features/{doh-rollout@mozilla.org.xpi,screenshots@mozilla.org.xpi,webcompat-reporter@mozilla.org.xpi,webcompat@mozilla.org.xpi}
sudo mv usr/lib/firefox /opt ; sudo ln -sf /opt/firefox/firefox /usr/local/bin ; sudo ln -sf /opt/firefox/firefox /usr/local/bin/browser
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
fi
}

CONFIGURAR(){
echo -n "Configurar o Firefox? [ S ou s = SIM ] " ; read RDK ; echo
if [[ $RDK = [sSyY] ]]; then
LOCAL=`pwd`
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
firefox --private-window --profile "$HOME/.mozilla/firefox/anon"
exit
EOF
chmod +x $HOME/.local/bin/anon
cat << EOF > $HOME/.local/bin/"$USER"
#!/bin/bash
firefox --profile "$HOME/.mozilla/firefox/$USER"
exit
EOF
chmod +x $HOME/.local/bin/"$USER"
fi
}

INSTALAR
CONFIGURAR

firefox --setDefaultBrowser --ProfileManager

cd $HOME

exit