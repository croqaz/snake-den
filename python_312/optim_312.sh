#!/usr/bin/env bash

set -euxo pipefail

SCRIPTF=$(realpath "$0")
SCRIPTD=$(dirname "$SCRIPTF")
BUILDER="${BUILDER:-cosmic}"

# Read env variables for CC, C++, LD, etc
source $SCRIPTD/../scripts/env-$BUILDER.sh

cd $ROOT/tmp/

NAME=pyoptim_312

# git clone https://github.com/python/cpython $NAME --branch=3.12 --single-branch --no-tags --depth=1

cd $ROOT/tmp/$NAME

git gc

cp $SCRIPTD/Setup_312 Modules/Setup

# Manual configure ...
# https://docs.python.org/3.12/using/configure.html
# Optimized mode flags from Cosmopolitan build/config.mk
#
./configure --disable-shared \
    --disable-test-modules \
    --with-ensurepip=no \
    --with-pymalloc \
    --with-static-libpython \
    --without-doc-strings \
    --without-system-expat \
    --without-system-libmpdec \
    --prefix=$ROOT/o/ \
    CCSHARED=" " \
    LDSHARED=" " \
    CPPFLAGS="-Oz" \
    OPT="-Oz -DNDEBUG -DSYSDEBUG -DSUPPORT_VECTOR=1 -Wall" \
    LDFLAGS="-static -static-libgcc -fno-semantic-interposition -L$ROOT/o/lib" \
    CFLAGS="-Oz -fmerge-all-constants -fno-semantic-interposition \
    -I$ROOT/o/include -I$ROOT/o/include/ncurses -I$ROOT/o/include/uuid" \
    MODULE_BUILDTYPE=static

make -j4 EXTRA_CFLAGS='-DTHREAD_STACK_SIZE=0x100000'

ls -lh python
./python --version
echo 'SUCCESS!'
