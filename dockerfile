FROM ubuntu:focal
RUN apt-get update && apt-get install -y tzdata
RUN apt-get update && apt-get install -y curl git nano python3 build-essential
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl
RUN curl -fsSL https://deb.nodesource.com/setup_16.x -o setup_16x.sh && /bin/bash setup_16x.sh && apt-get install -y nodejs
RUN node -v
RUN npm install --global yarn
RUN yarn global add wetty
COPY config.json /opt/
ENV user=kube
ENV password=kubepassword
VOLUME /config
RUN useradd -s /bin/bash -d /home/${user} -p $(openssl passwd -1 ${password} ) ${user}
RUN mkdir /home/${user} && mkdir /config && mkdir /config/.kube && rm /setup_16x.sh 
COPY config /config/.kube/
RUN chown -R ${user}:${user} /home/${user} && chown -R ${user}:${user} /config
EXPOSE 3000
COPY wetty.sh /opt/
ENTRYPOINT [ "/opt/wetty.sh" ] 