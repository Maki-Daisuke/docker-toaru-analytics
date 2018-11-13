FROM ubuntu:18.04

RUN apt update && apt upgrade -y                               && \
    apt install -y curl jq graphviz webp imagemagick parallel  && \
    apt clean

# Modify /etc/ImageMagick-6/policy.xml so that ImageMagick can use full of resources of this machine.
RUN cp /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xml.bak                    && \
    perl -npe '!/^\s*<!--\s/ and / domain="resource" / and chomp and $_="<!-- $_ -->\n"'     \
         < /etc/ImageMagick-6/policy.xml.bak > /etc/ImageMagick-6/policy.xml

# We install node.js using nvm instead of apt, because we need newer version to use async/await
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash  && \
    bash -c ". /root/.nvm/nvm.sh  &&  nvm install 10.13.0"

CMD ["bash", "-l"]
