chrome headless
======================
[![Build Status](https://travis-ci.org/tutorabc/chrome-headless.svg?branch=master)](https://travis-ci.org/tutorabc/chrome-headless)
[![Docker Pulls](https://img.shields.io/docker/pulls/tutorabcvfe/chrome-headless.svg)](https://hub.docker.com/r/tutorabcvfe/chrome-headless/tags/)

#### How to run?
```shell
$ docker run -p 9222:9222 --name chrome-headless -d tutorabcvfe/chrome-headless
```

#### Using docker compose
```yaml
version: '2'

services:
    chrome-headless:
    image: tutorabcvfe/chrome-headless:latest
    restart: always
    ports:
      - 9222:9222
    environment:
      - CHROME_ARGS=--hide-scrollbars --window-size="1280,1696"
```
[See all chrome options](https://peter.sh/experiments/chromium-command-line-switches/)

#### Using with [puppeteer](https://github.com/GoogleChrome/puppeteer/blob/master/docs/api.md#puppeteerconnectoptions)
```js
const puppeteer = require('puppeteer');
const axios = require('axios');

(async () => {
  const endpoint = 'http://localhost:9222';
  let browserWSEndpoint = await axios({ url: `${endpoint}/json/version` });
  browserWSEndpoint = browserWSEndpoint.data.webSocketDebuggerUrl;
  const browser = await puppeteer.connect({ browserWSEndpoint, ignoreHTTPSErrors: true });
  const page = await browser.newPage();
  await page.go('https://www.google.com');
})()
```
