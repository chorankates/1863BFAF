#!/bin/bash
# h/t http://stackoverflow.com/a/10586169

# dependencies check
if [ -z `which curl` ]; then
  echo "ERROR: unable to find 'curl' in \$PATH, skipping"
  exit 0
else
  echo 'running curl tests'
fi

# test definition/execution
ROUTES=`curl -s http://1863BFAF.pwnz.org:4567/meta`
EC=$?
if [ ${EC} != 0 ]; then
  echo "  unable to get routes, is the server running?"
  exit 2
fi

ROUTES=`echo ${ROUTES} | tr -d '\[' | tr -d '\]' | tr -d '"'`
IFS=', ' read -r -a URLS <<< "${ROUTES}"

for index in "${!URLS[@]}"; do
    echo "[$index] ${URLS[index]}.."
    RESPONSE=`curl -s ${URLS[index]}`
    EC=$?
    if [ ${EC} != 0 ]; then
      # fail fast
      echo "  non-0 exitcode[${EC}] response[${RESPONSE}]"
      exit 1
    fi
done

