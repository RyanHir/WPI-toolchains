#! /usr/bin/env bash

source "$ROOT_DIR/scripts/repack_tools.sh" || exit

rm -rf tree-{build,install}
mkdir tree-{build,install}
if [ "$WPITARGET" != "sysroot" ]; then
    for dir in {sysroot,libcxx,wrapper}-install; do
        echo "$dir/"
        rsync "$dir/" tree-build -a --copy-links
    done
    rsync "${BUILD_HOST_DIR}/llvm-install/" tree-build -a --copy-links
else
    pushd "sysroot-install"
    # fix-links
    popd
    rsync "sysroot-install/" tree-build -a --copy-links
fi
mv "cmake-toolchain.cmake" "tree-build/${WPIPREFIX}"
pushd tree-build
du -hs .

WPI_TREE_OUT="frc${V_YEAR}/${TARGET_OS}/"

rm -rf "${WPI_TREE_OUT}"
mkdir -p "${WPI_TREE_OUT}"

rsync -a "./${TARGET_TUPLE}/" "${WPI_TREE_OUT}/${TARGET_TUPLE}"
rsync -a "./${WPIPREFIX}/" "${WPI_TREE_OUT}/"
rm -rf "./${WPIPREFIX}/"

ALIASES_TO_CLANG=(
    as
    cc
    c++
    gcc
    g++
    clang
    clang++
)
ALIASES_TO_LLVM=(
    addr2line
    ar
    nm
    objcopy
    objdump
    ranlib
    strings
    strip
)
if [ "$WPITARGET" = "Windows" ]; then
    BIN_EXT=".exe"
fi
pushd "${WPI_TREE_OUT}"
pushd bin
mv wrapper$BIN_EXT .wrapper$BIN_EXT
for target in "${ALIASES_TO_CLANG[@]}"; do
    if [ "$target" != clang ]; then
        ln -s clang$BIN_EXT "${target}${BIN_EXT}"
    fi
    ln -s .wrapper$BIN_EXT "$TARGET_TUPLE-${target}${BIN_EXT}"
done
for target in "${ALIASES_TO_LLVM[@]}"; do
    ln -s "llvm-${target}${BIN_EXT}" "$TARGET_TUPLE-${target}${BIN_EXT}"
done
cp "$ROOT_DIR/downloads/llvm-mingw/$WPIHOSTTARGET/bin/"lib*.dll .
popd
rm -rf share/info share/man
rm -rf lib/xtables
du -hs .

popd # frcYYYY/
popd # tree-build

mv "tree-build/frc${V_YEAR}/" "tree-install/frc${V_YEAR}"
