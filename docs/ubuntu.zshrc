# Atualizado: 13/04/2019

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh
#xport ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="gnzh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(compleat common-aliases extract zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=pt_BR.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ALIASES
alias gtcl='git clone --depth 1'
alias wgtd='mkdir -p ~/temp/`date +%d-%m-%Y` ; wget -c --directory-prefix=~/temp/`date +%d-%m-%Y`'
alias pingoo='ping -c3 google.com'
alias pingit='ping -c3 github.com'
alias ls='ls -la --color=auto'
alias ezsh='nohup geany ~/.zshrc'
alias shutoff='sudo shutdown -c ; clear ; echo ; echo "Desligamento cancelado!" ; echo'
alias shutnow='sudo shutdown -h now' # Desligar agora
alias shutime='sudo shutdown -h' # Desligamento agendado
alias edit='nohup sudo geany' # Editar como sudo
alias logoff='clear ; echo " " ; echo "A sessão será encerrada! Salve seus trabalhos e pressione..." ; echo "uma tecla para continuar ou [CTRL]+[C] para cancelar..." ; read tecla ; pkill -9 -u $USER'
alias it='sudo apt install --no-install-recommends ; sudo apt install -f -y'
alias it-d='sudo apt install -d'
alias sr='apt search'
alias cl='sudo apt clean -y ; sudo apt autoclean -y ; sudo apt remove -y ; sudo apt autoremove -y'
alias rm-='sudo apt remove ; sudo apt autoremove -y'
alias rm+='sudo apt remove --purge ; sudo apt autoremove -y'
alias ccache='sudo rm -rf $HOME/.cache/*'
alias ctrash='rm -rf $HOME/.local/share/Trash/files/* ; rm -rf $HOME/.local/share/Trash/info/*'
alias rebootime='sudo shutdown -r' # Reiniciar programado
alias rec='echo "Gravação iniciará em 3 segundos..." ; mkdir -p ~/Screencast ; sleep 3 ; ffmpeg -f x11grab -s 1920x1080 -i :0.0 -r 30 -vcodec libx264 ~/Screencast/screencast-`date +%d-%m-%Y_%H:%M:%S`.mp4'
alias rconky='killall conky ; nohup sh /opt/conky/conky-startup.sh'
alias kconky='killall conky'
alias econky="geany /opt/conky/conky-startup.sh ; rconky"
alias setzsh='chsh -s /bin/zsh'
alias setbash='chsh -s /bin/bash'
alias reiniciar='sudo reboot'
alias desligar='sudo poweroff'
alias myf='sudo chown -R ${USER}:root'
alias sfolder='sudo du -sh'
alias uzsh='clear ; . ~/.zshrc'
alias biosclock='sudo hwclock --systohc --utc'
alias tree='find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"'
alias up-='sudo rm -rf /var/lib/dpkg/lock ; sudo apt update -y'
alias up+='sudo rm -rf /var/lib/dpkg/lock ; sudo apt update -y ; sudo apt dist-upgrade -y ; sudo apt install -f -y'
alias status-services='sudo systemctl status systemd-modules-load.service'
alias sysoff='sudo systemctl disable'
alias syson='sudo systemctl enable'
alias systart='sudo systemctl start'
alias systop='sudo systemctl stop'
alias reboot='sudo reboot'
alias poweroff='sudo poweroff'
alias shutdown='sudo shutdown'
alias esrc='nohup sudo geany /etc/apt/sources.list'
alias autologin-off='sudo cp /etc/lightdm/lightdm.conf.autologin.off /etc/lightdm/lightdm.conf'
alias autologin-on='sudo cp /etc/lightdm/lightdm.conf.autologin.on /etc/lightdm/lightdm.conf'
alias dl+='sudo mkdir -p $HOME/Downloads/Downloads-APT ; cd $HOME/Downloads/Downloads-APT ; sudo apt download'
alias hi+='history'
alias sw='apt show'
alias ldmoff='sudo systemctl disable lightdm.service'
alias ldmon='sudo systemctl enable lightdm.service'
alias rofi-adapta='sudo cp /usr/local/bin/rofi-drun-adapta /usr/local/bin/rofi-drun'
alias rofi-adwaita='sudo cp /usr/local/bin/rofi-drun-adwaita /usr/local/bin/rofi-drun'
alias myf='sudo chown -R ${USER}:root'
alias ucheck="clear ; echo "Updates:" ; apt -s dist-upgrade | awk '/^Inst/ { print $2 }'"
alias key-add='sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys'
alias key-rm='sudo apt-key del'
alias rcinn='nohup cinnamon --replace > /dev/null 2>&1 &'
alias nf='clear ; neofetch'
alias nemoq='nemo -q'
#alias it+='sudo apt install --no-install-recommends -y ; sudo apt install -f -y'
#alias wget='wget --no-check-certificate -c'
#alias ex+='pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY'
#alias ubash='clear ; . ~/.bashrc'
#alias menumaker='xdgmenumaker -n -f jwm > jwm-menu ; geany $HOME/jwm-menu $HOME/.jwmrc ; jwm -reload'
#alias emenu='geany $HOME/.jwmrc ; jwm -reload'
#alias ropb='openbox --reconfigure'
#alias edesktop='sudo geany /usr/share/applications/show-desktop.desktop'

########################
# Aplicativos
export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/nano
########################

########################
# Funções

# função sprunge
function spr() {
curl -F 'sprunge=<-' http://sprunge.us
}
# sintaxe exemplo "cat /local/ARQUIVO | spr" (sem os "")

# função setime (ajusta a hora usando a Internet)
function setime() {
sudo date -s "$(wget -qSO- --max-redirect=0 google.com 2>&1 | grep Date: | cut -d' ' -f5-8)Z"
}

# função reencoder abra o terminal na pasta ORIGEM, defina a pasta destino mudando o valor de reencf

# saida: codec: x264 | bitrate 2000k | 24fps | dimensão 700x394 | audio mp3 lame 112k
function reenclv1() {
# define a pasta destino
export reencf="/media/$USER/EXTPART/XXX/Cenas"
mkdir -p $reencf
for i in *.mp4; do ffmpeg -i "$i" -map_metadata -1 -map_metadata -1 -b:v 2000k -c:v libx264 -vf scale=700x394 -r 24 -c:a libmp3lame -b:a 112k -ac 2 -ar 44100 -threads 2 -f mp4 "$reencf/${i%.*}.mp4"; done ; clear ; echo -e "\nReeencoder finalizado!!!"
}

# saida: codec: x264 | bitrate 2000k | 24fps | dimensão 700x394 | audio aac 128k
function reenclv2() {
# define a pasta destino
export reencf="/media/$USER/EXTPART/XXX/Cenas"
mkdir -p $reencf
for i in *.mp4; do ffmpeg -i "$i" -map_metadata -1 -b:v 2000k -c:v libx264 -vf scale=700x394 -r 24 -c:a aac -b:a 128k -ac 2 -ar 44100 -threads 2 -f mp4 "$reencf/${i%.*}.mp4"; done ; clear ; echo -e "\nReeencoder finalizado!!!"
}

# saida: codec: x264 | bitrate 3000k | 24fps | dimensão 1280x720 | audio aac 160k
function reenclv3() {
# define a pasta destino
export reencf="/media/$USER/EXTPART/XXX/Cenas"
mkdir -p $reencf
for i in *.mp4; do ffmpeg -i "$i" -map_metadata -1 -b:v 3000k -c:v libx264 -vf scale=1280x720 -r 24 -c:a aac -b:a 160k -ac 2 -ar 44100 -threads 2 -f mp4 "$reencf/${i%.*}.mp4"; done ; clear ; echo -e "\nReeencoder finalizado!!!"
}
########################

# Terminal Tilix 
#if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
#        source /etc/profile.d/vte.sh
#fi
