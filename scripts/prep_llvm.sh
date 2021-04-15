#! /usr/bin/env bash

source "$SCRIPT_DIR/downloads_tools.sh"

LLMV_REPO="https://github.com/llvm/llvm-project/releases/download/llvmorg-${V_LLVM}"
LLVM_MINGW_BUILDS="https://github.com/mstorsjo/llvm-mingw/releases/download/20201020"

mkdir -p "${ROOT_DIR}/downloads"
pushd "$ROOT_DIR/downloads"
rm -rf llvm-toolchains
echo "[INFO]: Downloading and Extracting llvm-project"
signed sig "$LLMV_REPO/llvm-project-${V_LLVM}.src.tar.xz"
tar xf "llvm-project-${V_LLVM}.src.tar.xz"
mv "llvm-project-$V_LLVM.src" "llvm-toolchains/"

rm -rf llvm-mingw
echo "[INFO]: Downloading and Extracting llvm-mingw"
basic-download "$LLVM_MINGW_BUILDS/llvm-mingw-20201020-ucrt-ubuntu-18.04.tar.xz"
tar xf "llvm-mingw-20201020-ucrt-ubuntu-18.04.tar.xz"
mv "llvm-mingw-20201020-ucrt-ubuntu-18.04" "llvm-mingw/"
popd
