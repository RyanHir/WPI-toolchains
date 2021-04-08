#! /usr/bin/env bash

set -e

rm -rf ${HOST_BUILD_DIR}/clang-install
mkdir -p ${HOST_BUILD_DIR}/clang-{build,install}
pushd ${HOST_BUILD_DIR}/clang-build

CMAKE_ARGS=(
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_PREFIX=${WPIPREFIX}"
    "-DLLVM_DIR=${HOST_BUILD_DIR}/llvm-install/${WPIPREFIX}/lib/cmake/llvm"
    "-DLLVM_BUILD_LLVM_DYLIB=ON"
    "-DLLVM_LINK_LLVM_DYLIB=ON"
    "-DLLVM_INSTALL_UTILS=ON"
    "-DLLVM_BUILD_TESTS=OFF"
    "-DLLVM_BUILD_DOCS=OFF"
    "-DLLVM_TARGETS_TO_BUILD=X86;AArch64;ARM"

    "-DLLVM_MAIN_SRC_DIR=$ROOT_DIR/downloads/llvm-toolchains/llvm/"
)

cmake "$ROOT_DIR/downloads/llvm-toolchains/clang/" \
    -G Ninja "${CMAKE_ARGS[@]}"
ninja
DESTDIR="${HOST_BUILD_DIR}/clang-install" ninja install

popd
