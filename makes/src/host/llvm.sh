#! /usr/bin/env bash

set -e

rm -r ${BUILD_DIR}/llvm-install
mkdir -p ${BUILD_DIR}/llvm-{build,install}
pushd ${BUILD_DIR}/llvm-build

CMAKE_ARGS=(
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_PREFIX=${WPIPREFIX}"
    "-DLLVM_BUILD_LLVM_DYLIB=ON"
    "-DLLVM_LINK_LLVM_DYLIB=ON"
    "-DLLVM_INSTALL_UTILS=ON"
    "-DLLVM_BUILD_TESTS=OFF"
    "-DLLVM_BUILD_DOCS=OFF"
    "-DLLVM_TARGETS_TO_BUILD=X86;AArch64;ARM"
)

cmake "$ROOT_DIR/downloads/llvm-toolchains/llvm/" \
    -G Ninja "${CMAKE_ARGS[@]}"
ninja all
DESTDIR="${BUILD_DIR}/llvm-install" ninja install

popd
