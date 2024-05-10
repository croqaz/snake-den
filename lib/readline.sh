#!/usr/bin/env bash

set -e

SCRIPTF=$(realpath "$0")  # full path
SCRIPT=$(basename $SCRIPTF) # file
SCRIPTD=$(dirname "$SCRIPTF") # folder

# Read env variables for CC, C++, LD, etc
source $SCRIPTD/../scripts/cosmic.sh

cd $ROOT/tmp/
echo $PWD

# The GNU Readline Library
# https://tiswww.case.edu/php/chet/readline/rltop.html
#
NAME="${SCRIPT%.*}"

mkdir $NAME
wget -nv -O $NAME.tar.gz https://ftp.gnu.org/gnu/readline/readline-8.2.tar.gz
tar xf $NAME.tar.gz --strip-components=1 -C $NAME
echo "Archive downloaded and extracted"

cd $ROOT/tmp/$NAME
echo $PWD

# Configure ...
./configure --enable-static --disable-shared \
    --enable-multibyte \
    --with-curses \
    --without-tests \
    --prefix=$ROOT/o/ \
    CFLAGS="-Os"

# Build ...
ape make
# Install ...
ape make install
