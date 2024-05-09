import { $ } from "bun";
import { dirname } from "path";
import { fileURLToPath } from "url";

const __dirname = dirname(fileURLToPath(import.meta.url));

// Prepare the environment and folders
//
import * as cosmic from "../scripts/cosmic.js";
const ROOT = process.env.ROOT;

// Python v3.11 + Plumbum
// https://plumbum.readthedocs.io
// https://github.com/tomerfiliba/plumbum
//
const NAME = "py_plumbum";

$.cwd(`${ROOT}/tmp/`);

// Download ...
await $`git clone https://github.com/python/cpython ${NAME} --branch=3.11 --single-branch --no-tags --depth=1`;

$.cwd(`${ROOT}/tmp/${NAME}`);
await $`git gc`;

// Use local modules/setup, all static
//
await $`cp ${__dirname}/Setup_311 Modules/Setup`;

// Manual configure ...
// Super tiny linux x86
await $`./configure --disable-shared --with-static-libpython \
    --without-doc-strings --without-system-expat --without-system-ffi \
    --without-system-libmpdec --with-pymalloc --with-ensurepip=no \
    --disable-test-modules --prefix=${ROOT}/o/ \
    CCSHARED=" " LDSHARED=" " LDFLAGS="-static -L${ROOT}/o/lib" \
    OPT="-Os -DTINY -DNDEBUG -DTRUSTWORTHY -Wall" CPPFLAGS="-Os" \
    CFLAGS="-Os -fno-align-functions -fno-align-jumps -fno-align-labels -fno-align-loops \
    -fschedule-insns2 -momit-leaf-frame-pointer -foptimize-sibling-calls -DDWARFLESS \
    -I${ROOT}/o/include -I${ROOT}/o/include/uuid"`;

// Build ...
await $`ape make -j4`;
// Check
await $`./python --version`;
