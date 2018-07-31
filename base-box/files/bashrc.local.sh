if [[ ${EUID} == 0 ]] ; then
        PS1='\[\033[01;35m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
else
        PS1='\[\033[02;33m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
fi

shopt -s checkwinsize

HISTFILESIZE=1000000
HISTSIZE=1000000
HISTCONTROL=ignoreboth:erasedups
HISTTIMEFORMAT="%F/%T%t"

alias l="ls -lh"
alias la="ls -lah"
alias lart="ls -larth"
alias g="grep --color=auto"
alias gr="grep --color=auto -r"
alias gi="grep --color=auto -i"
alias gir="grep --color=auto -ir"

