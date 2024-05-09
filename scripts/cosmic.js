//
// Cosmopolitan toolchain setup
//
import { $ } from "bun";
import { fileURLToPath } from "url";
// If script is running as main
const isMain = process.argv[1] === fileURLToPath(import.meta.url);

const ROOT = "/root";
const ARCH = (await $`uname -m`.text()).trim();

const COSMOCC = `${ROOT}/cosmocc`;
const PREFIX = `${COSMOCC}/bin/${ARCH}-unknown-cosmo`;

const ENV = {
  ROOT,
  ARCH,
  MODE: ARCH,
  CC: `${PREFIX}-cc`,
  CXX: `${PREFIX}-c++`,
  AR: `${PREFIX}-ar`,
  LD: `${ROOT}/cosmocc/bin/${ARCH}-linux-cosmo-ld`,
  STRIP: `${PREFIX}-strip`,
  OBJCOPY: `${PREFIX}-objcopy`,
  ZIPCOPY: `${COSMOCC}/bin/zipcopy`,
  APELINK: `${COSMOCC}/bin/apelink`,
  COSMO: `${ROOT}/cosmopolitan`,
  COSMOCC,
};

$.env(ENV);

// Eg: eval $(bun scripts/cosmic.js)
//
for (const [k, v] of Object.entries(ENV)) {
  if (isMain) {
    console.log(`export ${k}=${v}`);
  } else {
    console.log(`${k}=${v}`);
    process.env[k] = v;
  }
}
