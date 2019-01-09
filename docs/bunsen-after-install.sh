#!/bin/bash

sudo apt remove --purge catfish* evince* filezilla* hardinfo* thunar* vlc* xfburn* xfce4-screenshooter

sudo rm -rf /usr/share/catfish/bin /usr/share/catfish/catfish /usr/share/catfish/catfish_lib /usr/lib/python3/dist-package /usr/lib/python3/dist-packages/pexpect

sudo apt install --no-install-recommends nemo nemo-fileroller cinnamon-l10n ; sudo ln -sf /usr/bin/nemo /usr/bin/bl-file-manager
