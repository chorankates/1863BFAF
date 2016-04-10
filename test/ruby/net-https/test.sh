#!/bin/bash
# dependencies check
if [ -z `which ruby` ]; then
  echo "ERROR: unable to find 'ruby' in \$PATH, skipping"
  exit 0
fi

# test definition/execution
TEST="`dirname $0`/test.rb"
echo "running [${TEST}]"
ruby ${TEST}