#!/usr/bin/env bash

set -euxo pipefail

SCRIPTF=$(realpath "$0")
SCRIPTD=$(dirname "$SCRIPTF")
BUILDER="${BUILDER:-cosmic}"

# Read env variables for CC, C++, LD, etc
source $SCRIPTD/../scripts/env-$BUILDER.sh

cd $ROOT/tmp/

NAME=pytiny_311

# git clone https://github.com/python/cpython $NAME --branch=3.11 --single-branch --no-tags --depth=1

cd $ROOT/tmp/$NAME

git gc

cp $SCRIPTD/Setup_311 Modules/Setup

# Manual configure ...
# https://docs.python.org/3.11/using/configure.html
# Super tiny linux x86 from Cosmopolitan build/config.mk
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
    CPPFLAGS="-Os" \
    LDFLAGS="-static -L$ROOT/o/lib" \
    OPT="-Os -DTINY -DNDEBUG -DTRUSTWORTHY -Wall" \
    CFLAGS="-Os -fno-align-functions -fno-align-jumps -fno-align-labels -fno-align-loops \
    -fschedule-insns2 -momit-leaf-frame-pointer -foptimize-sibling-calls -DDWARFLESS \
    -I$ROOT/o/include -I$ROOT/o/include/ncurses -I$ROOT/o/include/uuid"

make -j4 EXTRA_CFLAGS='-DTHREAD_STACK_SIZE=0x100000'

ls -lh python
./python --version
echo 'SUCCESS!'
