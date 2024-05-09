#
# Cosmopolitan toolchain vars
# eval $(cosmic.sh)
#
echo export ROOT="/root"
echo export ARCH=$(uname -m)

echo "export COSMOCC=$ROOT/cosmocc"
echo "export COSMO=$ROOT/cosmopolitan"

echo "export CC=$ARCH-unknown-cosmo-cc"
echo "export CXX=$ARCH-unknown-cosmo-c++"
echo "export AR=$ARCH-unknown-cosmo-ar"
echo "export LD=$ARCH-linux-cosmo-ld"
echo "export STRIP=$ARCH-unknown-cosmo-strip"
echo "export OBJCOPY=$ARCH-unknown-cosmo-objcopy"
