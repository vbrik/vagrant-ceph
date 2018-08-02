if [[ $- == *i* ]]; then
    alias vi=vim
    mountpoint -q /vagrant && HISTFILE=/vagrant/.hist/$(hostname -s).$UID
fi
