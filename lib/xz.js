import { $ } from "bun";

// Prepare the environment and folders
//
import * as cosmic from "../scripts/cosmic.js";
const ROOT = process.env.ROOT;

// XZ Utils
//
const NAME = "xz";

$.cwd(`${ROOT}/tmp/`);

await $`mkdir ${NAME}`;
await $`wget -nv -O ${NAME}.tar.gz https://sourceforge.net/projects/lzmautils/files/xz-5.4.6.tar.gz/download`;
await $`tar xf ${NAME}.tar.gz --strip-components=1 -C ${NAME}`;
console.log("Archive downloaded and extracted");

$.cwd(`${ROOT}/tmp/${NAME}`);

// Configure ...
await $`./configure --enable-shared=no --enable-static=yes --disable-rpath \
  --without-pic --enable-sandbox=no --prefix=${ROOT}/o/ CFLAGS="-Os"`;

// Build ...
await $`ape make`;
// Install ...
await $`ape make install`;
