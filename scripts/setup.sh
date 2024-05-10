
export ROOT=/root
export ARCH=$(uname -m)

export COSMOCC=$ROOT/cosmocc
export COSMO=$ROOT/cosmopolitan

mkdir -v -p $ROOT/o/    # Output folder
mkdir -v -p $ROOT/tmp/  # Temp working dir

cp -fv $COSMO/build/bootstrap/ape.elf /usr/bin/ape

# usr/local/bin has a higher priority in $PATH
cp -fv $COSMO/build/bootstrap/make /usr/local/bin/

# export PATH=/usr/local/bin:/usr/sbin:/usr/bin:$COSMO/build/bootstrap:$COSMOCC/bin
# echo PATH=$PATH

# Compile & setup cosmocc (only from time to time)
# (cd $COSMO && bash tool/cosmocc/package.sh ../cosmocc)
