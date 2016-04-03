#!/bin/bash
## test.sh is the endpoint that is used to run tests under the ruby harness
TEST="`dirname $0`/test.rb"
echo "running [${TEST}]"
ruby ${TEST}
