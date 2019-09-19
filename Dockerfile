FROM ubuntu:18.10

# Install system node.js and npm using apt to install `n`,
# then install the specific version of node.js using `n`.
# After installing node.js, uninstall `n`, system node.js and npm.
# See this article for details: https://qiita.com/seibe/items/36cef7df85fe2cefa3ea
# Then, install Puppeteer's dependencies and Puppeteer.
# See the following URL for the list of Puppeteer's dependencies:
# https://github.com/GoogleChrome/puppeteer/blob/93843592da58efcb28cf740dd7dbfa9f04061fc8/docs/troubleshooting.md
RUN apt update && apt upgrade -y                                            && \
    apt install -y curl jq graphviz webp imagemagick parallel               && \
    apt install -y nodejs npm                                               && \
    npm install -g n  &&  n 10.16.3                                         && \
    rm -rf `which n`  &&  apt purge -y nodejs npm                           && \
    apt install -y gconf-service libasound2 libatk1.0-0 libatk-bridge2.0-0     \
        libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1          \
        libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0        \
        libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6        \
        libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1             \
        libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6     \
        ca-certificates fonts-liberation libappindicator1 libnss3              \
        lsb-release xdg-utils wget                                          && \
    apt autoremove -y &&  apt clean  &&  rm -rf /var/lib/apt/lists/*

# Modify /etc/ImageMagick-6/policy.xml so that ImageMagick can use full of resources of this machine.
RUN cp /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xml.bak                    && \
    perl -npe '!/^\s*<!--\s/ and / domain="resource" / and chomp and $_="<!-- $_ -->\n"'     \
         < /etc/ImageMagick-6/policy.xml.bak > /etc/ImageMagick-6/policy.xml

WORKDIR /app
CMD ["bash", "-l"]
