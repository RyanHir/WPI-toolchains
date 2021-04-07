#! /usr/bin/env bash

source "$SCRIPT_DIR/downloads_tools.sh"

REPO="https://github.com/llvm/llvm-project/releases/download/llvmorg-${V_LLVM}"

PROJECTS=(
    llvm
    clang
    clang-tools-extra
    lld
    libclc
    libcxx
    libcxxabi
    libunwind
    flang
    compiler-rt
    openmp

)

pushd "$ROOT_DIR/downloads"
rm -rf llvm-toolchains
mkdir llvm-toolchains
for proj in "${PROJECTS[@]}"; do
    echo "[INFO]: Downloading and Extracting $proj"
    signed sig "$REPO/$proj-${V_LLVM}.src.tar.xz"
    tar xf "$proj-${V_LLVM}.src.tar.xz"
    mv "$proj-$V_LLVM.src" "llvm-toolchains/"
done
popd
