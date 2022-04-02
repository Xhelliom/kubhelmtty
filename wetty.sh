#!/bin/bash
useradd -s /bin/bash -d /home/${user} -p $(openssl passwd -1 ${password} ) ${user}
mkdir /home/${user}
mkdir /home/${user}/.kube
mkdir /config 
mkdir /config/.kube
chown -R ${user}:${user} /home/${user}
chown -R ${user}:${user} /config
ln -s /config/.kube/config /home/${user}/.kube/config
wetty --conf /opt/config.json
