FROM ubuntu:18.04

RUN apt update && apt upgrade -y                                      && \
    apt install -y curl jq graphviz webp imagemagick parallel         && \
    apt install -y nodejs npm                                         && \
    npm install -g n                                                  && \
    n 10.13.0                                                         && \
    rm -rf `which n`  &&  apt purge -y nodejs npm                     && \
    apt autoremove -y &&  apt clean  &&  rm -rf /var/lib/apt/lists/*
# Install system version of node.js and npm to install `n`, 
# then install the specific version of node.js using `n`.
# After installing node.js, uninstall `n`, system node.js and npm.
# See this article for details: https://qiita.com/seibe/items/36cef7df85fe2cefa3ea

# Modify /etc/ImageMagick-6/policy.xml so that ImageMagick can use full of resources of this machine.
RUN cp /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xml.bak                    && \
    perl -npe '!/^\s*<!--\s/ and / domain="resource" / and chomp and $_="<!-- $_ -->\n"'     \
         < /etc/ImageMagick-6/policy.xml.bak > /etc/ImageMagick-6/policy.xml

CMD ["bash", "-l"]
