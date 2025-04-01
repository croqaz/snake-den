#!/usr/bin/env bash

set -euxo pipefail

SCRIPTF=$(realpath "$0")  # full path
SCRIPT=$(basename $SCRIPTF) # file
SCRIPTD=$(dirname "$SCRIPTF") # folder
BUILDER="${BUILDER:-cosmic}"

# Read env variables for CC, C++, LD, etc
source $SCRIPTD/../scripts/env-$BUILDER.sh

cd $ROOT/tmp/

# XML parser and toolkit
# https://gitlab.gnome.org/GNOME/libxml2
#
NAME="${SCRIPT%.*}"

mkdir -p $NAME
wget -nv -O $NAME.tar.gz https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.12.6/libxml2-v2.12.6.tar.gz
tar xf $NAME.tar.gz --strip-components=1 -C $NAME
echo "Archive downloaded and extracted"

cd $ROOT/tmp/$NAME
echo $PWD

# Configure ...
./autogen.sh --enable-static --disable-shared \
    --without-debug \
    --without-icu \
    --without-python \
    --without-sax1 \
    --prefix=$ROOT/o/ \
    CFLAGS="-Os -fPIC"

# Build ...
ape make
# Install ...
ape make install

# Organize and cleanup
mv $ROOT/o/include/libxml2/libxml $ROOT/o/include
rm -r $ROOT/o/include/libxml2/

echo 'OK!'
