#
# Clang LLVM toolchain vars
#
export ROOT="/root"
export ARCH=$(uname -m)

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export AR=/usr/bin/llvm-ar
export STRIP=/usr/bin/llvm-strip
export OBJCOPY=/usr/bin/llvm-objcopy

# apt install cpp libc-dev clang llvm
# update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100
# update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100
# update-alternatives --install /usr/bin/ar ar /usr/bin/llvm-ar 100
# update-alternatives --install /usr/bin/strip strip /usr/bin/llvm-strip 100
