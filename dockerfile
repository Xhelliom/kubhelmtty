FROM ubuntu:focal
RUN apt-get update && apt-get install -y tzdata
RUN apt-get update && apt-get install -y curl git nano python3 build-essential
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl
RUN curl -fsSL https://deb.nodesource.com/setup_16.x -o setup_16x.sh && /bin/bash setup_16x.sh && apt-get install -y nodejs  && rm /setup_16x.sh 
RUN node -v
RUN npm install --global yarn
RUN yarn global add wetty
COPY config.json /opt/
COPY wetty.sh /opt/
ENV user=kube
ENV password=kubepassword
VOLUME /config

RUN mkdir /home/${user} && mkdir /home/${user}/.kube && mkdir /config && mkdir /config/.kube
COPY config /config/.kube/
RUN ln -s /config/.kube/config /home/${user}/.kube/config
EXPOSE 3000
ENTRYPOINT [ "/opt/wetty.sh" ] 