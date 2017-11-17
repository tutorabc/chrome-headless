#!/bin/bash

CHROME_OPTS="--disable-gpu --headless --no-sandbox --remote-debugging-address=0.0.0.0 --remote-debugging-port=9222 --user-data-dir=/home/chrome"

if [ -n "$CHROME_ARGS" ]; then
  CHROME_ARGS="${CHROME_OPTS} ${CHROME_ARGS}"
fi

sh -c "/usr/bin/google-chrome-stable $CHROME_ARGS"