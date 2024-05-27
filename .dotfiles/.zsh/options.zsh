setopt autocd autopushd pushdminus pushdsilent pushdtohome
setopt extendedglob
setopt histignoredups
unsetopt nomatch
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit