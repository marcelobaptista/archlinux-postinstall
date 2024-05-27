# Docker
alias dstart="docker start"
alias drestart="docker restart"
alias dstop="docker stop"
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}"'
alias dpsa='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}"'
alias dup="docker-compose up -d"

# Kubectl
alias kubectl="kubecolor"
alias k="kubectl"

# Ferramentas de Rede
alias meuip="curl ipinfo.io"
alias ping="ping -c 5"
alias ss="ss -tulnpa"
alias traceroute="traceroute -I"

# Ferramentas do Sistema
alias df="df -hT"
alias du="du -h"
alias free="free -h"
alias kill="kill -9"
alias psa="ps aux"
alias psg="ps aux | grep"
alias tailf="tail -f"
alias tree="tree -C"

# Gerenciamento de diretórios e arquivos
alias copia="rsync -razvh --progress"
alias lS="ls -1FSsh"
alias grep="grep --color=auto"
alias unzip="unzip -q"
alias untar="tar -zxvf"
alias untarxz="tar -Jxvf"

# Gerenciamento de pacotes
alias atu="sudo pacman -Syu && yay -Syu"
alias pam="yay -S"
alias pac="sudo pacman -S"
alias par="sudo pacman -R"

# Git
alias ga="git add"
alias gc="git commit"
alias gd="git diff"
alias gl="git log --oneline --decorate --graph"
alias gbr="git branch"
alias gc="git commit"
alias gco="git checkout"
alias gpl="git pull"
alias gps="git push"
alias gs="git status"

# Systemd
alias disable="sudo systemctl disable"
alias dreload="sudo systemctl daemon-reload"
alias enable="sudo systemctl enable"
alias reload="sudo systemctl reload"
alias restart="sudo systemctl restart"
alias start="sudo systemctl start"
alias status="systemctl status"
alias stop="sudo systemctl stop"

# Terraform
alias tfa="terraform apply"
alias tfd="terraform destroy"
alias tfi="terraform init"
alias tfp="terraform plan"

# Vagrant
alias vd="vagrant destroy -f"
alias vu="vagrant up"
alias vss="vagrant ssh"
