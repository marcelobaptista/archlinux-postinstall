#!/bin/bash

# Instalação de temas, ícones e fontes
pacman -Sy --noconfirm - < appearance-packages.txt

# Instalação de pacotes comuns
pacman -Sy --noconfirm - < common-packages.txt

# Instalação de pacotes do repo AUR
su - marcelo -c "
yay -S --noconfirm \
    camset dxvk-bin etcher-bin grub-theme-arch-linux \
    kubecolor phantomjs plymouth-theme-arch-logo \
    rar teams-for-linux terraform-{docs,ls} unetbootin \
    vagrant-vmware-utility vmware-host-modules-dkms-git \
    xerox-phaser-3020"

# Download de plugins do Oh My Zsh!
rm -rf /usr/share/oh-my-zsh/custom/*
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
