if [[ $- == *i* ]]; then
    alias vi=vim
    mountpoint -q /vagrant && HISTFILE=/vagrant/$(hostname -s).hist
fi
