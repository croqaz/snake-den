
export ROOT=/root
export ARCH=$(uname -m)

export COSMOCC=$ROOT/cosmocc
export COSMO=$ROOT/cosmopolitan

mkdir -p $ROOT/o/    # Output folder
mkdir -p $ROOT/tmp/  # Temp working dir

cp -fv $COSMO/build/bootstrap/ape.elf /usr/bin/ape

# usr/local/bin has a higher priority in $PATH
cp -fv $COSMO/build/bootstrap/make /usr/local/bin/

# Fixupobj, Objbincopy, Zipobj ...
cp -fv $COSMO/build/bootstrap/*obj* /usr/local/bin/
# Gzip, Zipcopy ...
cp -fv $COSMO/build/bootstrap/*zip* /usr/local/bin/

# Compile & setup cosmocc (only from time to time)
# (cd $COSMO && bash tool/cosmocc/package.sh ../cosmocc)

# Apelink ...
cp -fv -RP $COSMOCC/bin/*link /usr/local/bin/

# Cosmo CC, Ar, Cross, Install ...
cp -vRP $COSMOCC/bin/cosmo* /usr/local/bin/
# ar & ld need full copies
cp -fv $COSMOCC/bin/*-cosmo-[al]* /usr/local/bin/
# the rest can maintain the symlinks
cp -vRP $COSMOCC/bin/*-cosmo-[cegnors]* /usr/local/bin/
