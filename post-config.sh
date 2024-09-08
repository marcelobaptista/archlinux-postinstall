#!/bin/bash

# Configuração do plymouth
cp /etc/mkinitcpio.conf{,.backup}
sed -i 's/udev/udev plymouth/' /etc/mkinitcpio.conf
plymouth-set-default-theme -R arch-logo
cp /etc/default/grub{,.backup}
sed -i 's/\(GRUB_CMDLINE_LINUX_DEFAULT=\).*/\1"quiet splash loglevel=3 rd.udev.log_priority=3 vt.global_cursor_default=0"/' /etc/default/grub
mkinitcpio -p linux && mkinitcpio -p linux-lts
grub-mkconfig -o /boot/grub/grub.cfg

# Políticas do Firefox
mkdir -p /etc/firefox/policies
cp -f ./policies.json /etc/firefox/policies/policies.json

# Configuração Chrony
cat <<EOF >/etc/chrony.conf
server 192.168.1.253 iburst
server a.st1.ntp.br iburst
server b.st1.ntp.br iburst
server c.st1.ntp.br iburst
server d.st1.ntp.br iburst
server a.ntp.br iburst
server b.ntp.br iburst
server c.ntp.br iburst
server gps.ntp.br iburst
keyfile /etc/chrony/chrony.keys
driftfile /var/lib/chrony/drift
maxupdateskew 100.0
dumponexit
dumpdir /var/lib/chrony
makestep 1.0 3
rtcsync
leapsectz right/UTC
logdir /var/log/chrony
EOF

# Configuração do Liquidctl
cat <<EOF >>/etc/systemd/system/liquidcfg.service
[Unit]
Description=Liquidctl service

[Service]
Type=oneshot
ExecStart=liquidctl initialize all
ExecStart=liquidctl set pump speed 70
ExecStart=liquidctl set fan speed 20 30  30 40  34 52  40 70  45 80  50 100

[Install]
WantedBy=default.target
EOF

# Configuração do Reflector
cat <<EOF >/etc/xdg/reflector/reflector.conf
# Reflector configuration file for the systemd service.
--save /etc/pacman.d/mirrorlist
--protocol https,http
--country Brazil
--latest 5
--sort age
EOF

# Adiciona usuário aos grupos
usermod -aG vboxusers marcelo
newgrp vboxusers
groupadd docker && usermod -aG docker marcelo
newgrp docker

# Recarrega o systemd e habilita os serviços
systemctl daemon-reload
systemctl enable --now blueman-mechanism bluetooth bluetooth-autoconnect \
    containerd cronie cups docker chronyd liquidcfg reflector sshd vboxservice

# Copia dotfiles
cp -rf ./dotfiles/* ~/ && chown -R marcelo:marcelo ~/

# Configuração do autologin no LightDM
sed -i 's/#autologin-user=$/autologin-user=marcelo/' /etc/lightdm/lightdm.conf
groupadd -r autologin && gpasswd -a marcelo autologin

# Configuração do modo kiosk no XFCE
mkdir -p /etc/xdg/xfce4/kiosk
cat <<EOF >/etc/xdg/xfce4/kiosk/kioskrc
[xfce4-session]
SaveSession=NONE
EOF
