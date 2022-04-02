#!/bin/bash
useradd -s /bin/bash -d /home/${user} -p $(openssl passwd -1 ${password} ) ${user}
chown -R ${user}:${user} /home/${user} && chown -R ${user}:${user} /config &&
wetty --conf /opt/config.json
