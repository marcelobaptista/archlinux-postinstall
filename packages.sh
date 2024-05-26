#!/bin/bash

pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
cp /etc/pacman.conf /etc/pacman.conf.backup
cat <<EOF >>/etc/pacman.conf

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF
pacman -Sy --noconfirm \
    adobe-source-sans-pro-fonts \
    amd-ucode \
    ansible \
    audacious \
    awesome-terminal-fonts \
    aws-cli \
    bind \
    blueman \
    bluetooth-autoconnect \
    calibre \
    cheese \
    chromium \
    chrony \
    containerd \
    cups \
    cups-pdf \
    dconf-editor \
    direnv \
    discord \
    docker \
    docker-{buildx,compose} \
    dosfstools \
    dotnet-sdk \
    downgrade \
    drawio-desktop \
    easyeffects \
    efibootmgr \
    evince \
    fd \
    firefox \
    firefox-i18n-pt-br \
    foliate \
    fzf \
    gimp \
    git \
    gnome-{calculator,disk-utility,keyring} \
    go \
    gparted \
    gptfdisk \
    grub-customizer \
    guake \
    gvfs-{mtp,nfs,onedrive,smb} \
    helm \
    heroic-games-launcher-bin \
    hwinfo \
    inkscape \
    java-{environment,runtime} \
    jdk-openjdk \
    joyutils \
    jq \
    k9s \
    ksnip \
    kubectl \
    kubectx \
    libreoffice-fresh \
    linux-lts-headers \
    liquidctl \
    mariadb-libs \
    mkvtoolnix-gui \
    nautilus \
    nautilus-{code-git,open-any-terminal} \
    net-tools \
    nmap \
    noto-fonts \
    numlockx \
    oh-my-zsh-git \
    p7zip-gui \
    pacman-contrib \
    perf \
    pip-tools \
    plank \
    plymouth \
    postgresql-libs \
    powerline-fonts \
    print-manager \
    qbittorrent \
    qt6-base \
    reflector \
    rsync \
    safeeyes \
    shell{check,harden} \
    shotwell \
    solaar \
    strace \
    tcpdump \
    telegram-desktop \
    termius \
    terraform \
    tidal-hifi-bin \
    traceroute \
    tree \
    ttf-{anonymous-pro,bitstream-vera,dejavu,droid,fira-mono,freefont,liberation,ms-fonts,opensans,roboto,roboto-mono,ubuntu-font-family} \
    ulauncher \
    usbutils \
    vagrant \
    vi \
    vim \
    virtualbox \
    virtualbox-{ext-oracle,guest-iso,guest-utils} \
    visual-studio-code-bin \
    vlc \
    waydroid \
    wine{tricks,-mono,} \
    xdg-user-dirs-gtk \
    xorg-xhost \
    xprintidle \
    yay \
    yq \
    zip \
    zsh \
    zsh-{autosuggestions,completions,history-substring-search,syntax-highlighting,theme-powerlevel10k-git} \
    zshdb \
    arc-icon-theme numix-icon-theme-git paper-icon-theme-git pop-icon-theme-git epapirus-icon-theme papirus-{folders,icon-theme}

su - marcelo -c "
yay -S --noconfirm \
    camset etcher-bin grub-theme-arch-linux plymouth-theme-arch-logo rar unetbootin"
    