#!/bin/bash
useradd -s /bin/bash -d /home/${user} -p $(openssl passwd -1 ${password} ) ${user}
wetty --conf /opt/config.json
