#!/usr/bin/env bash

set -euxo pipefail

SCRIPTF=$(realpath "$0")  # full path
SCRIPT=$(basename $SCRIPTF) # file
SCRIPTD=$(dirname "$SCRIPTF") # folder
BUILDER="${BUILDER:-cosmic}"

# Read env variables for CC, C++, LD, etc
source $SCRIPTD/../scripts/env-$BUILDER.sh

NAME="${SCRIPT%.*}"

cd $ROOT/o/

if [ -f ./include/bzlib.h ]; then
    echo "OK bzlib.h"
else
    cp $COSMO/third_party/bzip2/bzlib.h ./include/
fi

if [ -f ./lib/libbz2.a ]; then
    echo "OK libbz2.a"
else
    cp $COSMO/o/third_party/bzip2/bzip2.a ./lib/libbz2.a
fi

echo 'OK!'
