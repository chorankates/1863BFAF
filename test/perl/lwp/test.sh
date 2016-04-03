#!/bin/bash
## harness
TEST="`dirname $0`/test.pl"
echo "running [${TEST}]"
perl ${TEST}
