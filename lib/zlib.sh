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

if [ -f ./include/zlib.h ]; then
    echo "OK zlib.h"
else
    echo "#ifndef THIRD_PARTY_ZLIB_COSMOS" > ./include/zlib.h
    echo "#define THIRD_PARTY_ZLIB_COSMOS" >> ./include/zlib.h
    echo '#include "third_party/zlib/zlib.h"' >> ./include/zlib.h
    echo "#ifdef THIRD_PARTY_ZLIB_COSMOS_GZ" >> ./include/zlib.h
    echo '#include "third_party/zlib/gz/gzguts.inc"' >> ./include/zlib.h
    echo "#endif" >> ./include/zlib.h
    echo '#define inflateBackInit(x, y, z) inflateBackInit_((x), (y), (z))' >> ./include/zlib.h
    echo "#endif" >> ./include/zlib.h
    echo "Created zlib.h"
fi

if [ -f ./lib/libz.a ]; then
    echo "OK libz.a"
else
    cp $COSMO/o/third_party/zlib/zlib.a ./lib/libz.a
    $AR rcu ./lib/libz.a $COSMO/o/third_party/zlib/gz/*.o
fi

echo 'OK!'
