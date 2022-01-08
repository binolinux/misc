#!/bin/bash

# instala e configura o firefox
# contato telegram: @rocker_raccoon
# atualizado em: 07.01.2022

clear
killall firefox >/dev/null 2>&1
killall firefox-bin >/dev/null 2>&1
LOCAL=`pwd`

INSTALAR() {
echo ; echo -n "Instalar o Firefox? [ S ou s = SIM ] " ; read RDK ; echo
if [[ $RDK = [sSyY] ]]; then
sudo pacman -Syu --needed --noconfirm extra/firefox extra/dbus-glib
#mkdir -p $HOME/.cache/firefox-setup ; cd $HOME/.cache/firefox-setup
#wget https://archlinux.org/packages/extra/any/firefox-i18n-pt-br/download -O firefox-ptbr.pkg.tar.zst
#wget https://archlinux.org/packages/community/any/firefox-ublock-origin/download -O ublock.pkg.tar.zst
#for i in *.* ;do tar -I zstd -xvf "$i"; done
sudo rm -f /usr/lib/firefox/browser/features/{doh-rollout@mozilla.org.xpi,screenshots@mozilla.org.xpi,webcompat-reporter@mozilla.org.xpi,webcompat@mozilla.org.xpi}
#sudo cp -ar usr/lib/firefox/browser/extensions /usr/lib/firefox/browser
sudo ln -sf /usr/lib/firefox/firefox /usr/local/bin/browser
#sudo rm -f /usr/share/applications/firefox.desktop
cat << EOF > $HOME/.local/share/applications/firefox.desktop
[Desktop Entry]
Version=1.0
Name=Firefox
Keywords=Internet;WWW;Browser;Web;Explorer;Explorador;Navegador
Exec=firefox %u
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
Exec=firefox --new-window %u

[Desktop Action new-private-window]
Name=New Private Window
Name[pt_BR]=Nova janela privativa
Exec=firefox --private-window %u
EOF
chmod +x $HOME/.local/share/applications/firefox.desktop ; rm -rf $HOME/.cache/firefox-setup
fi
}

CONFIGURAR(){
clear ; echo ; echo -n "Configurar o Firefox? [ S ou s = SIM ] " ; read RDK ; echo
if [[ $RDK = [sSyY] ]]; then
timeout 6s firefox
DEFAULT=`ls $HOME/.mozilla/firefox | grep default-release | sed -n '1p'`
cd "$LOCAL"
mkdir -p "$LOCAL"/perfil/extensions ; rm -f "$LOCAL"/perfil/browsec@browsec.com.xpi ; rm -f "$LOCAL"/perfil/langpack-pt-BR@firefox.mozilla.org.xpi ; rm -f "$LOCAL"/perfil/uBlock0@raymondhill.net.xpi
wget --content-disposition https://addons.mozilla.org/firefox/downloads/file/3869267 -O "$LOCAL"/perfil/extensions/browsec@browsec.com.xpi
wget --content-disposition https://addons.mozilla.org/firefox/downloads/file/3883426 -O "$LOCAL"/perfil/extensions/langpack-pt-BR@firefox.mozilla.org.xpi
wget --content-disposition https://addons.mozilla.org/firefox/downloads/file/3886236 -O "$LOCAL"/perfil/extensions/uBlock0@raymondhill.net.xpi
echo 'user_pref("browser.download.dir", "'$HOME'/.cache");' >> "$LOCAL"/perfil/prefs.js
rm -rf $HOME/.mozilla/firefox/"$DEFAULT" ; mkdir -p $HOME/.local/bin $HOME/.mozilla/firefox/"$DEFAULT"
cp -rT "$LOCAL"/perfil/ $HOME/.mozilla/firefox/"$DEFAULT"
firefox --ProfileManager
fi
}

INSTALAR
CONFIGURAR

cd $HOME

exit
