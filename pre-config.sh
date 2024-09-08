#!/bin/bash

# Configuração do sudo
cat <<EOF >>/etc/sudoers.d/sudoers
marcelo ALL=(ALL) NOPASSWD: ALL
EOF

# Configuração do pacman
cp /etc/pacman.conf{,.backup}
sed -i "s/#UseSyslog/UseSyslog/g; \
        s/#Color/Color/g; \
        s/#ParallelDownloads = 5/ParallelDownloads = 5/g" \
        /etc/pacman.conf

# Atualização do mirrorlist
cp /etc/pacman.d/mirrorlist{,.backup}
cat <<'EOF' >/etc/pacman.d/mirrorlist
Server = https://mirror.ufscar.br/archlinux/$repo/os/$arch
Server = http://archlinux.c3sl.ufpr.br/$repo/os/$arch
Server = http://mirror.ufam.edu.br/archlinux/$repo/os/$arch
Server = http://linorg.usp.br/archlinux/$repo/os/$arch
EOF

# Instalação do repo Chaotic-AUR
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U --noconfirm https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-{keyring,mirrorlist}.pkg.tar.zst
cat <<EOF >>/etc/pacman.conf

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF

# Remove o beep do sistema
rmmod pcspkr
cat <<EOF >>/etc/modprobe.d/blacklist.conf
blacklist pcspkr
blacklist snd_pcsp
EOF

# Limite do tamanho do Journal
cp /etc/systemd/journald.conf{,.bak}
sed -i "s/#SystemMaxUse=/SystemMaxUse=300M/" /etc/systemd/journald.conf
systemctl restart systemd-journald.service
journalctl --vacuum-size=100M
journalctl --vacuum-time=2weeks

# Configuração do SSH
cp /etc/ssh/sshd_config{,.backup}
sed -i -e 's/^#\(PermitRootLogin.*\)/PermitRootLogin no/' \
        -e 's/^#\(MaxAuthTries.*\)/MaxAuthTries 3/' \
        -e 's/^#\(LoginGraceTime.*\)/LoginGraceTime 20/' \
        -e 's/^#\(X11Forwarding.*\)/X11Forwarding no/' \
        -e 's/^#\(AllowTcpForwarding.*\)/AllowTcpForwarding no/' \
        -e 's/^#\(AllowAgentForwarding.*\)/AllowAgentForwarding no/' \
        -e 's/^#\(PermitEmptyPasswords.*\)/PermitEmptyPasswords no/' \
        -e 's/^#\(PermitTunnel.*\)/PermitTunnel no/'
systemctl restart sshd.service
