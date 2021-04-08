#! /usr/bin/env bash

set -e

rm -r ${BUILD_DIR}/lld-install
mkdir -p ${BUILD_DIR}/lld-{build,install}
pushd ${BUILD_DIR}/lld-build

CMAKE_ARGS=(
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_PREFIX=${WPIPREFIX}"
    "-DLLVM_BUILD_LLVM_DYLIB=ON"
    "-DLLVM_LINK_LLVM_DYLIB=ON"
    "-DLLVM_INSTALL_UTILS=ON"
    "-DLLVM_BUILD_TESTS=OFF"
    "-DLLVM_BUILD_DOCS=OFF"
    "-DLLVM_TARGETS_TO_BUILD=X86;AArch64;ARM"
    "-DLLVM_MAIN_SRC_DIR=$ROOT_DIR/downloads/llvm-toolchains/llvm/"
)

cmake "$ROOT_DIR/downloads/llvm-toolchains/lld/" \
    -G Ninja "${CMAKE_ARGS[@]}"
ninja
DESTDIR="${BUILD_DIR}/lld-install" ninja install

popd
