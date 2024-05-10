#!/usr/bin/env bash

set -e

SCRIPT=$(realpath "$0")
SCRIPTDIR=$(dirname "$SCRIPT")

# Read env variables for CC, C++, LD, etc
source $SCRIPTDIR/../scripts/cosmic.sh

echo CC=$CC
echo CXX=$CXX

cd $ROOT/tmp/
echo $PWD

NAME=pyoptim_312

# git clone https://github.com/python/cpython $NAME --branch=3.12 --single-branch --no-tags --depth=1

cd $ROOT/tmp/$NAME
echo $PWD

git gc

cp $SCRIPTDIR/Setup_312 Modules/Setup

# Manual configure ...
# https://docs.python.org/3.12/using/configure.html
# Optimized mode flags from Cosmopolitan build/config.mk
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
    CPPFLAGS="-Oz" \
    OPT="-Oz -DNDEBUG -DSYSDEBUG -DSUPPORT_VECTOR=1 -Wall" \
    LDFLAGS="-static -static-libgcc -fno-semantic-interposition -L$ROOT/o/lib" \
    CFLAGS="-Oz -fmerge-all-constants -fno-semantic-interposition \
    -I$ROOT/o/include I$ROOT/o/include/gdbm -I$ROOT/o/include/uuid" \
    MODULE_BUILDTYPE=static

ape make -j4 EXTRA_CFLAGS="$CFLAGS -DTHREAD_STACK_SIZE=0x100000"

ls -lh python
./python --version
echo 'SUCCESS!'
