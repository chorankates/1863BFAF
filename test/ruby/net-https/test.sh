#!/bin/bash
## test.sh is the endpoint that is used to run tests under the ruby harness
TEST= `printf '%s/test.rb', `cwd``
ruby ${TEST}


