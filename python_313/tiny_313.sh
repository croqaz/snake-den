#!/usr/bin/env bash

set -euxo pipefail

SCRIPTF=$(realpath "$0")
SCRIPTD=$(dirname "$SCRIPTF")
BUILDER="${BUILDER:-cosmic}"

# Read env variables for CC, C++, LD, etc
source $SCRIPTD/../scripts/env-$BUILDER.sh

cd $ROOT/tmp/

NAME=pytiny_313

# git clone https://github.com/python/cpython $NAME --branch=3.13 --single-branch --no-tags --depth=1

cd $ROOT/tmp/$NAME

# git gc

cp $SCRIPTD/Setup_313 Modules/Setup

# Manual configure ...
# Super tiny linux x86 from Cosmopolitan build/config.mk
#
./configure --disable-shared --with-static-libpython \
    --without-doc-strings \
    --disable-test-modules \
    --without-system-expat \
    --without-system-libmpdec \
    --with-pymalloc \
    --with-ensurepip=no \
    --prefix=$ROOT/o/ \
    CCSHARED=" " \
    LDSHARED=" " \
    CPPFLAGS="-Os" \
    OPT="-Os -DTINY -DNDEBUG -DTRUSTWORTHY -Wall" \
    LDFLAGS="-static -static-libgcc -L$ROOT/o/lib" \
    CFLAGS="-Os -fno-align-functions -fno-align-jumps -fno-align-labels -fno-align-loops \
    -fschedule-insns2 -momit-leaf-frame-pointer -foptimize-sibling-calls -DDWARFLESS \
    -I$ROOT/o/include -I$ROOT/o/include/uuid" \
    MODULE_BUILDTYPE=static

make -j4 EXTRA_CFLAGS='-DTHREAD_STACK_SIZE=0x100000'

ls -lh python
./python --version
echo 'SUCCESS!'
