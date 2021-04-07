#! /usr/bin/env bash

set -e

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
)

cmake "$ROOT_DIR/downloads/llvm-toolchains/llvm/" \
    -G Ninja "${CMAKE_ARGS[@]}"
ninja all
DESTDIR="${BUILD_DIR}/llvm-install" ninja install

popd
