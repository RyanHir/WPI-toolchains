#! /usr/bin/env bash

set -e

rm -rf ${HOST_BUILD_DIR}/lld-install
mkdir -p ${HOST_BUILD_DIR}/lld-{build,install}
pushd ${HOST_BUILD_DIR}/lld-build

CMAKE_ARGS=(
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_PREFIX=${WPIPREFIX}"
    "-DLLVM_BUILD_LLVM_DYLIB=ON"
    "-DLLVM_LINK_LLVM_DYLIB=ON"
    "-DLLVM_INSTALL_UTILS=ON"
    "-DLLVM_BUILD_TESTS=OFF"
    "-DLLVM_BUILD_DOCS=OFF"
    "-DLLVM_TARGETS_TO_BUILD=X86;AArch64;ARM"
    
    # Some undocumented, found by cmake-gui
    "-DLLVM_TABLEGEN_EXE=${HOST_BUILD_DIR}/llvm-build/bin/llvm-tblgen"
    "-DLLVM_MAIN_INCLUDE_DIR=${HOST_BUILD_DIR}/llvm-install/${WPIPREFIX}/include"
    "-DLLVM_MAIN_SRC_DIR=$ROOT_DIR/downloads/llvm-toolchains/llvm/"
    "-DLLVM_OBJ_ROOT=${HOST_BUILD_DIR}/llvm-install/${WPIPREFIX}/"
)

cmake "$ROOT_DIR/downloads/llvm-toolchains/lld/" \
    -G Ninja "${CMAKE_ARGS[@]}"
ninja
DESTDIR="${HOST_BUILD_DIR}/lld-install" ninja install

popd
