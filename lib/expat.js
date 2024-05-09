import { $ } from "bun";

// Prepare the environment and folders
//
import * as cosmic from "../scripts/cosmic.js";
const ROOT = process.env.ROOT;

// Expat: fast streaming XML parser written in C99
// https://github.com/libexpat/libexpat
//
const NAME = "expat";

$.cwd(`${ROOT}/tmp/`);

await $`mkdir ${NAME}`;
await $`wget -nv -O ${NAME}.tar.gz https://github.com/libexpat/libexpat/releases/download/R_2_5_0/expat-2.5.0.tar.gz`;
await $`tar xf ${NAME}.tar.gz --strip-components=1 -C ${NAME}`;
console.log("Archive downloaded and extracted");

$.cwd(`${ROOT}/tmp/${NAME}`);

// Configure ...
await $`./configure --enable-static --disable-shared \
    --without-pic --with-gnu-ld --disable-tests --disable-examples \
    --without-docbook --with-getrandom --prefix=${ROOT}/o/ CFLAGS="-Os"`;

// Build ...
await $`ape make`;
// Install ...
await $`ape make install`;
