#! /usr/bin/env bash

set -e

rm -rf ${HOST_BUILD_DIR}/llvm-install
mkdir -p ${HOST_BUILD_DIR}/llvm-{build,install}
pushd ${HOST_BUILD_DIR}/llvm-build

CMAKE_ARGS=(
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_PREFIX=${WPIPREFIX}"
    "-DLLVM_INSTALL_UTILS=ON"
    "-DLLVM_BUILD_TESTS=OFF"
    "-DLLVM_BUILD_DOCS=OFF"
    "-DLLVM_ENABLE_PROJECTS=clang;clang-tools-extra;lld"
    "-DLLVM_TARGETS_TO_BUILD=X86;AArch64;ARM"
    "-DLIBCLANG_BUILD_STATIC=ON"
    "-DLLVM_INSTALL_TOOLCHAIN_ONLY=ON"
    "-DLLVM_ENABLE_TERMINFO=OFF"
    "-DLLVM_INSTALL_TOOLCHAIN_ONLY=ON"
)

if [ "$WPITARGET" = "Windows" ]; then
    # bash
    CMAKE_ARGS+=(
        "-DCMAKE_SYSTEM_NAME=Windows"
        "-DCMAKE_CROSSCOMPILING=TRUE"
        "-DCMAKE_C_COMPILER=$WPIHOSTTARGET-clang"
        "-DCMAKE_ASM_COMPILER=$WPIHOSTTARGET-clang"
        "-DCMAKE_CXX_COMPILER=$WPIHOSTTARGET-clang++"
        "-DCMAKE_RC_COMPILER=$WPIHOSTTARGET-windres"
        "-DLLVM_ENABLE_LLD=ON"
        "-DCROSS_TOOLCHAIN_FLAGS_NATIVE="
        "-DCMAKE_FIND_ROOT_PATH=$ROOT_DIR/downloads/llvm-mingw/$WPIHOSTTARGET"
        "-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER"
        "-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY"
        "-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY"
    )
else
    CMAKE_ARGS+=(
        "-DLLVM_BUILD_LLVM_DYLIB=ON"
        "-DLLVM_LINK_LLVM_DYLIB=ON"
    )
fi

cmake "$ROOT_DIR/downloads/llvm-toolchains/llvm/" \
    -G Ninja "${CMAKE_ARGS[@]}"
ninja $NINJA_ARGS all
DESTDIR="${HOST_BUILD_DIR}/llvm-install" ninja install
# exit 1
popd
