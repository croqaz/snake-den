import { $ } from "bun";
import { dirname } from "path";
import { fileURLToPath } from "url";

const __dirname = dirname(fileURLToPath(import.meta.url));

// Prepare the environment and folders
//
import * as cosmic from "../scripts/cosmic.js";
const ROOT = process.env.ROOT;

// Python v3.11
//
const NAME = "python311";

$.cwd(`${ROOT}/tmp/`);

// Download ...
// await $`git clone https://github.com/python/cpython ${NAME} --branch=3.11 --single-branch --no-tags --depth=1`;

$.cwd(`${ROOT}/tmp/${NAME}`);

// Use local modules/setup, all static
await $`cp ${__dirname}/Setup-311 Modules/Setup`;

// Configure ...
await $`./configure --disable-shared --with-static-libpython \
    --without-system-expat --without-system-ffi \
    --without-system-libmpdec --with-pymalloc --with-ensurepip=no \
    --prefix=${ROOT}/o/ LDFLAGS="-static -L${ROOT}/o/lib" \
    CFLAGS="-Os -static -I${ROOT}/o/include -I${ROOT}/o/include/uuid"`;

// Build ...
await $`ape make`;
// Check
await $`./python --version`;
