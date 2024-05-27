#!/bin/bash

# Configuração do sudo
cat <<EOF >>/etc/sudoers.d/sudoers
marcelo ALL=(ALL) NOPASSWD: ALL
EOF

# Configuração temporária do pacman
cp /etc/pacman.d/mirrorlist{,.backup}
cat <<'EOF' >/etc/pacman.d/mirrorlist
Server = https://mirror.ufscar.br/archlinux/$repo/os/$arch
Server = http://archlinux.c3sl.ufpr.br/$repo/os/$arch
Server = http://mirror.ufam.edu.br/archlinux/$repo/os/$arch
Server = http://linorg.usp.br/archlinux/$repo/os/$arch
EOF

# Invoca os scripts de instalação
source packages.sh
source config.sh

reboot