#!/bin/bash
# dependencies check
if [ -z `which perl` ]; then
  echo "ERROR: unable to find 'perl' in \$PATH, skipping"
  exit 0
fi

# test definition/execution
TEST="`dirname $0`/test.pl"
echo "running [${TEST}]"
perl ${TEST}