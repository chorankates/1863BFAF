#!/bin/bash
# dependencies check
if [ -z `which java` ]; then
  echo "ERROR: unable to find 'java' in \$PATH, skipping"
  exit 0
fi

# definition
DIR=`dirname $0`
TEST="${DIR}/Test.java"

# compilation
echo "compiling [${TEST}]"
javac ${TEST}

# execution
echo "running [${TEST}]"
cd ${DIR}
java Test