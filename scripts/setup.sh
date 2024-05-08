
export ROOT=/root
export ARCH=$(uname -m)

export COSMOCC=$ROOT/cosmocc
export COSMO=$ROOT/cosmopolitan

cp -v $COSMO/build/bootstrap/ape.elf /usr/bin/ape
cp -v $COSMO/build/bootstrap/make /usr/local/bin/

# Apelink ...
cp -v -RP $COSMOCC/bin/*link /usr/local/bin/
# Cosmo CC, Ar, Cross, Install ...
cp -v -RP $COSMOCC/bin/cosmo* /usr/local/bin/
cp -v -RP $COSMOCC/bin/*-linux-cosmo-* /usr/local/bin/
cp -v -RP $COSMOCC/bin/*-unknown-cosmo-* /usr/local/bin/

# Fixupobj, Objbincopy, Zipobj ...
cp -v $COSMO/build/bootstrap/*obj* /usr/local/bin/
# Gzip, Zipcopy ...
cp -v $COSMO/build/bootstrap/*zip* /usr/local/bin/

# Remove bad links
rm /usr/local/bin/*-cosmo-as
rm /usr/local/bin/*-cosmo-ld*
cp $COSMOCC/bin/*-cosmo-as /usr/local/bin/
cp $COSMOCC/bin/*-cosmo-ld* /usr/local/bin/
