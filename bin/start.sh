#!/bin/bash

# Run the NSSDB updating utility in background
# import-cert.sh $HOME &

ARGS="--disable-gpu --headless --no-sandbox --remote-debugging-address=0.0.0.0 --remote-debugging-port=9222 --user-data-dir=/home/chrome"

if [ -n "$CHROME_ARGS" ]; then
  CHROME_ARGS="${ARGS} ${CHROME_ARGS}"
fi

sh -c "/usr/bin/google-chrome-stable $ARGS"