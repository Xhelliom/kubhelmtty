FROM ubuntu:focal
RUN apt-get update && apt get install -y curl git nano python3 nodejs npm build-essential
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl
RUN npm install --global yarn
RUN yarn global add wetty
COPY config.json /
EXPOSE 3000
COPY wetty.sh /
ENTRYPOINT [ "wetty.sh" ] 