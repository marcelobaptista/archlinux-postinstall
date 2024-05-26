#!/bin/bash

sudo cp /etc/mkinitcpio.conf{,.bkp}
sed -i 's/udev/udev plymouth/' /etc/mkinitcpio.conf
mkinitcpio -p linux && mkinitcpio -p linux-lts
plymouth-set-default-theme -R arch-logo

mkdir -p /etc/firefox/policies
cp ./policies.json /etc/firefox/policies/policies.json

rmmod pcspkr

cat <<EOF >>/etc/modprobe.d/blacklist.conf
blacklist pcspkr
blacklist snd_pcsp
EOF

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

cat <<EOF >>/etc/systemd/system/liquidcfg.service
[Unit]
Description=AIO startup service

[Service]
Type=oneshot
ExecStart=liquidctl initialize all
ExecStart=liquidctl set pump speed 70
ExecStart=liquidctl set fan speed 20 30  30 40  34 52  40 70 45 80 50 100

[Install]
WantedBy=default.target
EOF

systemctl daemon-reload
systemctl enable --now blueman-mechanism bluetooth bluetooth-autoconnect \
    containerd cups docker chronyd liquidcfg reflector sshd vboxservice
