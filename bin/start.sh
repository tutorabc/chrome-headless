#!/bin/bash

ARGS="--disable-gpu --headless --no-sandbox --remote-debugging-address=0.0.0.0 --remote-debugging-port=9222"

if [ -n "$CHROME_ARGS" ]; then
  ARGS="${ARGS} ${CHROME_ARGS}"
fi

sh -c "/usr/bin/google-chrome-unstable $ARGS"
