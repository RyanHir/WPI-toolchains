#! /usr/bin/env bash

source "$SCRIPT_DIR/downloads_tools.sh"

REPO="https://github.com/llvm/llvm-project/releases/download/llvmorg-${V_LLVM}"

pushd "$ROOT_DIR/downloads"
rm -rf llvm-toolchains
echo "[INFO]: Downloading and Extracting llvm-project"
signed sig "$REPO/llvm-project-${V_LLVM}.src.tar.xz"
tar xf "llvm-project-${V_LLVM}.src.tar.xz"
mv "llvm-project-$V_LLVM.src" "llvm-toolchains/"
popd
