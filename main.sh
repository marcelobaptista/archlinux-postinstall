#!/bin/bash

cat <<EOF >>/etc/sudoers.d/sudoers
marcelo ALL=(ALL) NOPASSWD: ALL
EOF

sed -i 's/#autologin-user=$/autologin-user=marcelo/' /etc/lightdm/lightdm.conf
groupadd -r autologin && gpasswd -a marcelo autologin

cp /etc/pacman.d/mirrorlist{,.bkp} 
cat <<'EOF' >/etc/pacman.d/mirrorlist
Server = https://mirror.ufscar.br/archlinux/$repo/os/$arch
Server = http://archlinux.c3sl.ufpr.br/$repo/os/$arch
Server = http://mirror.ufam.edu.br/archlinux/$repo/os/$arch
Server = http://linorg.usp.br/archlinux/$repo/os/$arch
EOF

source packages.sh
source services.sh