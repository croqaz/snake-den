#
# Cosmopolitan toolchain vars
#
export ROOT="/root"
export ARCH=$(uname -m)

export COSMOCC="$ROOT/cosmocc"
export COSMO="$ROOT/cosmopolitan"

export CC=$COSMOCC/bin/$ARCH-unknown-cosmo-cc
export CXX=$COSMOCC/bin/$ARCH-unknown-cosmo-c++
export AR=$COSMOCC/bin/$ARCH-unknown-cosmo-ar
export LD=$COSMOCC/bin/$ARCH-linux-cosmo-ld
export STRIP=$COSMOCC/bin/$ARCH-unknown-cosmo-strip
export OBJCOPY=$COSMOCC/bin/$ARCH-unknown-cosmo-objcopy
