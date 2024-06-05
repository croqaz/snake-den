#!/usr/bin/env bash

set -euxo pipefail

SCRIPTF=$(realpath "$0")  # full path
SCRIPT=$(basename $SCRIPTF) # file
SCRIPTD=$(dirname "$SCRIPTF") # folder
BUILDER="${BUILDER:-cosmic}"

# Read env variables for CC, C++, LD, etc
source $SCRIPTD/../scripts/env-$BUILDER.sh

cd $ROOT/tmp/

# Expat: fast streaming XML parser written in C99
# https://github.com/libexpat/libexpat
#
NAME="${SCRIPT%.*}"

mkdir -p $NAME
wget -nv -O $NAME.tar.gz https://github.com/libexpat/libexpat/releases/download/R_2_5_0/expat-2.5.0.tar.gz
tar xf $NAME.tar.gz --strip-components=1 -C $NAME
echo "Archive downloaded and extracted"

cd $ROOT/tmp/$NAME

# Configure ...
./configure --enable-static --disable-shared \
    --with-getrandom \
    --with-gnu-ld \
    --without-docbook \
    --without-examples \
    --without-pic \
    --without-tests \
    --prefix=${ROOT}/o/ CFLAGS="-Os"

# Build ...
make
# Install ...
make install

echo 'OK!'
