FROM ubuntu:xenial

LABEL name="chrome-headless" \ 
    maintainer="tutorabc VFE <vfe@vipabc.com>" \
    description="Dockerized Google Chrome Headless"

ADD bin/start.sh  /usr/bin/

RUN mkdir -p /usr/share/fonts/noto

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    && wget -O /usr/bin/dumb-init \
    https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 \
    && curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" \
    > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update && apt-get install -y \
    google-chrome-stable \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# install fonts
RUN cd /usr/share/fonts/noto && \
    # wget https://github.com/emojione/emojione-assets/releases/download/3.1.2/emojione-android.ttf &&\
    wget https://github.com/googlei18n/noto-cjk/blob/master/NotoSansCJKsc-Medium.otf?raw=true && \
    wget https://github.com/CartoDB/cartodb/blob/master/app/assets/fonts/helvetica.ttf?raw=true && \
    wget https://github.com/adampash/Lifehacker.me/blob/master/fonts/HelveticaNeue.ttf?raw=true && \
    fc-cache -f -v

RUN chmod u+x /usr/bin/dumb-init \
    /usr/bin/start.sh

EXPOSE 9222

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/usr/bin/start.sh"]
