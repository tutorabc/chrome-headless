FROM ubuntu:xenial

LABEL name="chrome-headless" \ 
    maintainer="tutorabc VFE <vfe@vipabc.com>" \
    description="Google Chrome Headless"

ADD bin/*.sh  /usr/bin/

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    inotify-tools \
    && curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update && apt-get install -y \
    google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64.deb \
    && dpkg -i dumb-init_*.deb \
    && rm dumb-init_1.2.0_amd64.deb

RUN google-chrome-stable --version

RUN chmod u+x /usr/bin/start.sh \
    && chmod u+x /usr/bin/import-cert.sh

RUN mkdir /data

VOLUME /data

EXPOSE 9222

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/usr/bin/start.sh"]