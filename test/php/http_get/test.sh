#!/bin/bash
# dependencies check
if [ -z `which php` ]; then
  echo "ERROR: unable to find 'php' in \$PATH, skipping"
  exit 0
fi

# test definition/execution
TEST="`dirname $0`/test.php"
echo "running [${TEST}]"
php ${TEST}