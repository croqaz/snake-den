import { $ } from "bun";

// Prepare the environment and folders
//
import * as cosmic from "../scripts/cosmic.js";
const ROOT = process.env.ROOT;

// The GNU Readline Library
// https://tiswww.case.edu/php/chet/readline/rltop.html
//
const NAME = "readline";

$.cwd(`${ROOT}/tmp/`);
await $`mkdir ${NAME}`;

await $`wget -nv -O ${NAME}.tar.gz https://ftp.gnu.org/gnu/readline/readline-8.2.tar.gz`;
await $`tar xf ${NAME}.tar.gz --strip-components=1 -C ${NAME}`;
console.log("Archive downloaded and extracted");

$.cwd(`${ROOT}/tmp/${NAME}`);
// Configure ...
await $`./configure --enable-static --disable-shared --enable-multibyte \
    --prefix=${ROOT}/o/ CFLAGS="-Os"`;

// Build ...
await $`ape make`;
// Install ...
await $`ape make install`;
