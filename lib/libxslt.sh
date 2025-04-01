#!/usr/bin/env bash

set -euxo pipefail

SCRIPTF=$(realpath "$0")  # full path
SCRIPT=$(basename $SCRIPTF) # file
SCRIPTD=$(dirname "$SCRIPTF") # folder
BUILDER="${BUILDER:-cosmic}"

# Read env variables for CC, C++, LD, etc
source $SCRIPTD/../scripts/env-$BUILDER.sh

cd $ROOT/tmp/

# XSLT processor
# https://gitlab.gnome.org/GNOME/libxslt
#
NAME="${SCRIPT%.*}"

mkdir -p $NAME
wget -nv -O $NAME.tar.gz https://gitlab.gnome.org/GNOME/libxslt/-/archive/v1.1.39/libxslt-v1.1.39.tar.gz
tar xf $NAME.tar.gz --strip-components=1 -C $NAME
echo "Archive downloaded and extracted"

cd $ROOT/tmp/$NAME
echo $PWD

# Configure ...
./autogen.sh --enable-static --disable-shared \
    --with-libxml-include-prefix=$ROOT/o/include \
    --with-libxml-libs-prefix=$ROOT/o/lib \
    --without-debug \
    --without-debugger \
    --without-pic \
    --without-profiler \
    --without-python \
    --prefix=$ROOT/o/ \
    CFLAGS="-Os -fPIC" LDFLAGS="-L$ROOT/o/lib -lxml2"

# Build ...
ape make
# Install ...
ape make install

# Cleanup
rm -r $ROOT/o/lib/libxslt-plugins/

echo 'OK!'
