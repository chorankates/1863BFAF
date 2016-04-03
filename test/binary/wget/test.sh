#!/bin/bash
# h/t http://stackoverflow.com/a/10586169

echo 'running wget tests'

ROUTES=`wget -qO- http://localhost:4567/meta`
ROUTES=`echo ${ROUTES} | tr -d '\[' | tr -d '\]' | tr -d '"'`
IFS=', ' read -r -a URLS <<< "${ROUTES}"

for index in "${!URLS[@]}"; do
    echo "[$index] ${URLS[index]}.."
    RESPONSE=`wget -qO- ${URLS[index]}`
    if [ $? != 0 ]; then
      # fail fast
      echo "  non-0 exitcode[$?]"
      exit 1
    fi
done

