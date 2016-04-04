#!/bin/bash
# dependencies check
if [ -z `which python` ]; then
  echo "ERROR: unable to find 'curl' in \$PATH, skipping"
  exit 0
fi

# test definition/execution
TEST="`dirname $0`/test.py"
echo "running [${TEST}]"
python ${TEST}