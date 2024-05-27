#!/bin/bash

# Instalação do repo Chaotic-AUR
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
cp /etc/pacman.conf{,.backup}
cat <<EOF >>/etc/pacman.conf

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF

# Instalação de temas, ícones e fontes
pacman -Sy --noconfirm \
    arc-icon-theme epapirus-icon-theme nordzy-icon-theme-git \
    numix-icon-theme-git paper-icon-theme-git \
    papirus-{folders,icon-theme} pop-icon-theme-git \
    adobe-source-sans-pro-fonts awesome-terminal-fonts \
    nerd-fonts powerline-fonts \
    ttf-{anonymous-pro,dejavu,droid,fira-mono,freefont,liberation,meslo-nerd-font-powerlevel10k,ms-fonts,opensans,roboto,roboto-mono,ubuntu-font-family}

# Instalação de pacotes
pacman -Sy --noconfirm \
    amd-ucode ansible audacious aws-cli \
    bind blueman bluetooth-autoconnect \
    calibre cheese chromium chrony containerd cups cups-pdf \
    dconf-editor deja-dup direnv discord docker docker-{buildx,compose} dosfstools dotnet-sdk downgrade drawio-desktop \
    easyeffects efibootmgr ethtool evince \
    fd firefox firefox-i18n-pt-br foliate fzf \
    gimp gnome-{calculator,disk-utility,keyring} go gparted gptfdisk grub-customizer guake gvfs-{mtp,nfs,onedrive,smb} \
    helm heroic-games-launcher-bin hwinfo \
    inkscape inxi iperf3 \
    java-{environment,runtime} jdk-openjdk joyutils jq \
    k9s ksnip kubectl kubectx \
    libreoffice-fresh linux-headers linux-lts-headers liquidctl lutris \
    mariadb-libs mkvtoolnix-gui \
    nano-syntax-highlighting nautilus nautilus-{code-git,open-any-terminal} net-tools nmap noto-fonts numlockx \
    oh-my-zsh-git onedrivegui\
    p7zip-gui pacman-contrib pamac-aur perf pip-tools plank plymouth postgresql-libs print-manager python-requests-oauthlib \
    qbittorrent qdirstat qt6-base \
    reflector rsync \
    safeeyes shell{check,harden} shotwell solaar steam strace \
    tcpdump teams-for-linux telegram-desktop termius terraform tidal-hifi-bin traceroute tree \
    ulauncher usbutils \
    vagrant vi vim virtualbox virtualbox-{ext-oracle,guest-iso,guest-utils} visual-studio-code-bin vlc \
    waydroid wine{tricks,-mono,} \
    xdg-user-dirs-gtk xorg-{xhost,xkill} xprintidle \
    yay yq \
    zip zsh zsh-theme-powerlevel10k-git zshdb

su - marcelo -c "
yay -S --noconfirm \
    camset dxvk-bin etcher-bin grub-theme-arch-linux kubecolor plymouth-theme-arch-logo rar teams-for-linux unetbootin"

# Download de plugins do Oh My Zsh!
rm -rf /usr/share/oh-my-zsh/custom/*
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"