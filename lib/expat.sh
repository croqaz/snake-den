#!/usr/bin/env bash

set -e

SCRIPTF=$(realpath "$0")  # full path
SCRIPT=$(basename $SCRIPTF) # file
SCRIPTD=$(dirname "$SCRIPTF") # folder

# Read env variables for CC, C++, LD, etc
source $SCRIPTD/../scripts/cosmic.sh

cd $ROOT/tmp/
echo $PWD

# Expat: fast streaming XML parser written in C99
# https://github.com/libexpat/libexpat
#
NAME="${SCRIPT%.*}"

mkdir $NAME
wget -nv -O $NAME.tar.gz https://github.com/libexpat/libexpat/releases/download/R_2_5_0/expat-2.5.0.tar.gz
tar xf $NAME.tar.gz --strip-components=1 -C $NAME
echo "Archive downloaded and extracted"

cd $ROOT/tmp/$NAME
echo $PWD

# Configure ...
./configure --enable-static --disable-shared \
    --disable-examples \
    --disable-tests \
    --with-getrandom \
    --with-gnu-ld \
    --without-docbook \
    --without-pic \
    --prefix=${ROOT}/o/ CFLAGS="-Os"

# Build ...
ape make
# Install ...
ape make install
