FROM ubuntu:18.04

RUN apt update && apt upgrade -y          && \
    apt install -y curl jq graphviz webp  && \
    apt clean

# We install node.js using nvm instead of apt, because we need newer version to use async/await
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash  && \
    bash -c ". /root/.nvm/nvm.sh  &&  nvm install 10.13.0"

CMD ["bash", "-l"]
