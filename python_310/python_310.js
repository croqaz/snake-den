import { $ } from "bun";
import { dirname } from "path";
import { fileURLToPath } from "url";

const __dirname = dirname(fileURLToPath(import.meta.url));

// Prepare the environment and folders
//
import * as cosmic from "../scripts/cosmic.js";
const ROOT = process.env.ROOT;

// Python v3.10
//
const NAME = "python_310";

$.cwd(`${ROOT}/tmp/`);

// Download ...
await $`git clone https://github.com/python/cpython ${NAME} --branch=3.10 --single-branch --no-tags --depth=1`;

$.cwd(`${ROOT}/tmp/${NAME}`);

// Use local modules/setup, all static
await $`cp ${__dirname}/Setup_310 Modules/Setup`;

// Configure ...
await $`./configure --disable-shared --with-static-libpython \
    --with-pymalloc --with-ensurepip=no \
    --prefix=${ROOT}/o/ LDFLAGS="-static -L${ROOT}/o/lib" CFLAGS="-Os -static"`;

// Build ...
await $`ape make`;
// Check
await $`./python --version`;
