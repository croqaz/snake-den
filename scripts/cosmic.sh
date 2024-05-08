
export ROOT="/root"
export ARCH=$(uname -m)

export COSMOCC=$ROOT/cosmocc
export COSMO=$ROOT/cosmopolitan

export CC=$ARCH-unknown-cosmo-cc
export CXX=$ARCH-unknown-cosmo-c++
export AR=$ARCH-unknown-cosmo-ar
export LD=$ARCH-linux-cosmo-ld
export STRIP=$ARCH-unknown-cosmo-strip
export OBJCOPY=$ARCH-unknown-cosmo-objcopy

mkdir -p $ROOT/o/
mkdir -p $ROOT/tmp/
