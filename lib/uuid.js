import { $ } from "bun";

// Prepare the environment and folders
//
import * as cosmic from "../scripts/cosmic.js";
const ROOT = process.env.ROOT;

// Portable UUID C library
// https://sourceforge.net/projects/libuuid/
//
const NAME = "uuid";

$.cwd(`${ROOT}/tmp/`);

await $`mkdir ${NAME}`;
await $`wget -nv -O ${NAME}.tar.gz https://sourceforge.net/projects/libuuid/files/libuuid-1.0.3.tar.gz/download`;
await $`tar xf ${NAME}.tar.gz --strip-components=1 -C ${NAME}`;
console.log("Archive downloaded and extracted");

$.cwd(`${ROOT}/tmp/${NAME}`);

// Tweak the source code
await $`sed -i 's/^static int flock/static int flock2/' gen_uuid.c`;
await $`sed -i 's/flock(state_fd, LOCK_/flock2(state_fd, LOCK_/g' gen_uuid.c`;

// Configure ...
await $`./configure --enable-static --disable-shared \
    --without-pic --with-gnu-ld --prefix=${ROOT}/o/ CFLAGS="-Os"`;

// Build ...
await $`ape make`;
// Install ...
await $`ape make install`;
