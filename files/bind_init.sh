#!/bin/bash

# LOG OUTPUT TO A FILE
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/root/.bind_automate/log.out 2>&1

if [[ ! -f "/root/.bind_automate/init.cfg" ]]
then
  # COPY CONFIG FILE
  cp /root/.bind_automate/named.conf.options /etc/bind/
  # RESTART bind9
  systemctl restart bind9
  # CHECK BIND STATUS
  systemctl status bind9
  touch /root/.bind_automate/init.cfg
fi
