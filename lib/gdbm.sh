#!/usr/bin/env bash

set -euxo pipefail

SCRIPTF=$(realpath "$0")  # full path
SCRIPT=$(basename $SCRIPTF) # file
SCRIPTD=$(dirname "$SCRIPTF") # folder
BUILDER="${BUILDER:-cosmic}"

# Read env variables for CC, C++, LD, etc
source $SCRIPTD/../scripts/env-$BUILDER.sh

cd $ROOT/tmp/

# GNU dbm (or GDBM, for short)
# https://gnu.org.ua/software/gdbm/
#
NAME="${SCRIPT%.*}"

mkdir $NAME
wget -nv -O $NAME.tar.gz https://ftp.gnu.org/gnu/gdbm/gdbm-1.23.tar.gz
tar xf $NAME.tar.gz --strip-components=1 -C $NAME
echo "Archive downloaded and extracted"

cd $ROOT/tmp/$NAME

# Configure ...
export COMPATINCLUDEDIR="$ROOT/o/include/gdbm"
./configure --enable-static --disable-shared \
    --disable-memory-mapped-io \
    --disable-nls \
    --disable-rpath \
    --enable-libgdbm-compat \
    --with-gnu-ld \
    --without-pic \
    --without-readline \
    --prefix=$ROOT/o/ \
    CFLAGS="-Os"

# Build ...
make
# Install ...
make install
