if [ $SHELL = "/bin/bash" ] ; then
    if [ $EUID -eq 0 ] ; then
        PS1="\[\033[31m\]\h\[\033[01;34m\] \W #\[\033[00m\] "
    else
        PS1="\[\033[32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "
    fi
fi
