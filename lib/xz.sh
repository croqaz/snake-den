#!/usr/bin/env bash

set -euxo pipefail

SCRIPTF=$(realpath "$0")  # full path
SCRIPT=$(basename $SCRIPTF) # file
SCRIPTD=$(dirname "$SCRIPTF") # folder
BUILDER="${BUILDER:-cosmic}"

# Read env variables for CC, C++, LD, etc
source $SCRIPTD/../scripts/env-$BUILDER.sh

cd $ROOT/tmp/

# XZ Utils
#
NAME="${SCRIPT%.*}"

mkdir -p $NAME
wget -nv -O $NAME.tar.gz https://sourceforge.net/projects/lzmautils/files/xz-5.4.6.tar.gz/download
tar xf $NAME.tar.gz --strip-components=1 -C $NAME
echo "Archive downloaded and extracted"

cd $ROOT/tmp/$NAME
echo $PWD

# Configure ...
./configure --enable-shared=no --enable-static=yes \
  --disable-rpath \
  --enable-sandbox=no \
  --without-pic \
  --prefix=${ROOT}/o/ CFLAGS="-Os"

# Build ...
ape make
# Install ...
ape make install

echo 'OK!'
