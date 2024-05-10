import { $ } from "bun";
import { dirname } from "path";
import { fileURLToPath } from "url";

const __dirname = dirname(fileURLToPath(import.meta.url));

// Prepare the environment and folders
//
import * as cosmic from "../scripts/cosmic.js";
const ROOT = process.env.ROOT;

// Python v3.12
//
const NAME = "python_312";

$.cwd(`${ROOT}/tmp/`);

// Download ...
await $`git clone https://github.com/python/cpython ${NAME} --branch=3.12 --single-branch --no-tags --depth=1`;

$.cwd(`${ROOT}/tmp/${NAME}`);
await $`git gc`;

// Use local modules/setup, all static
//
await $`cp ${__dirname}/Setup_312 Modules/Setup`;

// Manual configure ...
// Optimized mode settings from Cosmopolitan build/config.mk
await $`./configure --disable-shared --with-static-libpython \
    --without-doc-strings --disable-test-modules --without-system-expat \
    --without-system-libmpdec --with-pymalloc --with-ensurepip=no \
    --prefix=${ROOT}/o/ CCSHARED=" " LDSHARED=" " \
    LDFLAGS="-static -static-libgcc -fno-semantic-interposition -L${ROOT}/o/lib" \
    CPPFLAGS="-Oz" CFLAGS="-Oz -fmerge-all-constants -fno-semantic-interposition \
    -I${ROOT}/o/include -I${ROOT}/o/include/uuid" MODULE_BUILDTYPE=static`;

// Build ...
await $`ape make -j4 EXTRA_CFLAGS="$CFLAGS -DTHREAD_STACK_SIZE=0x100000"`;
// Check
await $`./python --version`;
