#!/usr/bin/env bash

set -e

SCRIPTF=$(realpath "$0")  # full path
SCRIPT=$(basename $SCRIPTF) # file
SCRIPTD=$(dirname "$SCRIPTF") # folder

# Read env variables for CC, C++, LD, etc
source $SCRIPTD/../scripts/cosmic.sh

cd $ROOT/tmp/
echo $PWD

# Portable UUID C library
# https://sourceforge.net/projects/libuuid/
#
NAME="${SCRIPT%.*}"

mkdir $NAME
wget -nv -O $NAME.tar.gz https://sourceforge.net/projects/libuuid/files/libuuid-1.0.3.tar.gz/download
tar xf $NAME.tar.gz --strip-components=1 -C $NAME
echo "Archive downloaded and extracted"

cd $ROOT/tmp/$NAME
echo $PWD

# Tweak the source code
sed -i 's/^static int flock/static int flock2/' gen_uuid.c
sed -i 's/flock(state_fd, LOCK_/flock2(state_fd, LOCK_/g' gen_uuid.c

# Configure ...
./configure --enable-static --disable-shared \
    --with-gnu-ld \
    --without-pic \
    --prefix=$ROOT/o/ \
    CFLAGS="-Os"

# Build ...
ape make
# Install ...
ape make install
