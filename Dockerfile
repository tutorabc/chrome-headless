FROM debian:sid

ENV DEBUG_ADDRESS=0.0.0.0 DEBUG_PORT=9222

LABEL name="chrome-headless" \ 
    maintainer="tutorabc VFE <vfe@vipabc.com>" \
    description="Google Chrome Headless"

RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64.deb \
    && dpkg -i dumb-init_*.deb \
    && rm dumb-init_1.2.0_amd64.deb

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    --no-install-recommends \
    && curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update && apt-get install -y \
    google-chrome-stable \
    --no-install-recommends \
    && apt-get purge --auto-remove -y curl gnupg \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r chrome && useradd -r -g chrome -G audio,video chrome \
    && mkdir -p /home/chrome && chown -R chrome:chrome /home/chrome

ADD ./bin/start.sh  /usr/bin/

USER chrome

EXPOSE 9222

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/usr/bin/start"]