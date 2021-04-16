#! /usr/bin/env bash

set -e

rm -rf ${BUILD_TARGET_DIR}/libcxx-install
mkdir -p ${BUILD_TARGET_DIR}/libcxx-build
pushd ${BUILD_TARGET_DIR}/libcxx-build

SYSROOT="$BUILD_TARGET_DIR/sysroot-install/$TARGET_TUPLE"

# TODO: Convert into cmake args
SYSROOT_LIB_FLAGS="-B$SYSROOT/usr/lib/$TARGET_TUPLE/$V_GCC -B$SYSROOT/usr/lib/gcc/$TARGET_TUPLE/$V_GCC"
TARGET_FLAGS=""
[ -n "$TARGET_CPU" ] && TARGET_FLAGS+=" -mcpu=${TARGET_CPU}" || true
[ -n "$TARGET_FPU" ] && TARGET_FLAGS+=" -mfpu=${TARGET_FPU}" || true
[ -n "$TARGET_FLOAT" ] && TARGET_FLAGS+=" -mfloat-abi=${TARGET_FLOAT}" || true
CXX_FLAGS="$TARGET_FLAGS $SYSROOT_LIB_FLAGS"
LINK_FLAGS="-fuse-ld=lld -L$SYSROOT/usr/lib/$TARGET_TUPLE/$V_GCC -L$SYSROOT/usr/lib/gcc/$TARGET_TUPLE/$V_GCC"
CMAKE_ARGS=(
    "-DCMAKE_BUILD_TYPE=MinSizeRel"
    "-DCMAKE_INSTALL_PREFIX=/usr"
    
    # libc++ options
    "-DLIBCXX_ENABLE_SHARED=ON"
    "-DLIBCXX_ENABLE_STATIC=ON"
    "-DLIBCXX_INCLUDE_TESTS=OFF"
    "-DLIBCXX_INCLUDE_BENCHMARKS=OFF"
    "-DLIBCXX_ENABLE_ABI_LINKER_SCRIPT=ON"

    # LLVM
    "-DLLVM_PATH=$ROOT_DIR/downloads/llvm-toolchains/llvm"

    # Tell CMake to crosscompile
    "-DCMAKE_CROSSCOMPILING=True"
    "-DCMAKE_SYSTEM_PROCESSOR=arm"
    "-DCMAKE_SYSTEM_NAME=Linux"
    "-DCMAKE_BUILD_TYPE=Release"

    # ABI support
    "-DLIBCXX_CXX_ABI=libstdc++"
    "-DLIBCXX_CXX_ABI_LIBRARY_PATH=$SYSROOT/usr/lib/libstdc++.so"
    "-DLIBCXX_CXX_ABI_INCLUDE_PATHS=$SYSROOT/usr/include/c++/${V_GCC};$SYSROOT/usr/include/c++/${V_GCC}/$TARGET_TUPLE"

    # Compiler Target
    "-DCMAKE_C_FLAGS=$CXX_FLAGS"
    "-DCMAKE_CXX_FLAGS=$CXX_FLAGS"
    "-DCMAKE_EXE_LINKER_FLAGS=$LINK_FLAGS"
    "-DCMAKE_SHARED_LINKER_FLAGS=$LINK_FLAGS"
    "-DCMAKE_SYSROOT=$SYSROOT"
    "-DCMAKE_LIBRARY_PATH=$SYSROOT/usr/lib;$SYSROOT/usr/lib/$TARGET_TUPLE/$V_GCC"
)

# Select Compiler
# TODO: Merge args
if [ "$WPITARGET" = "Windows" ]; then
    # TODO: Test with Ubuntu 20.04 clang
    CMAKE_ARGS+=(
        "-DCMAKE_C_COMPILER=$MINGW_DIR/bin/clang"
        "-DCMAKE_C_COMPILER_TARGET=$TARGET_TUPLE"
        "-DCMAKE_CXX_COMPILER=$MINGW_DIR/bin/clang++"
        "-DCMAKE_CXX_COMPILER_TARGET=$TARGET_TUPLE"
        "-DCMAKE_AR=$MINGW_DIR/bin/llvm-ar"
    )
else
    RECENT_CLANG_BUILD_TARGET_DIR="$BUILD_HOST_DIR/llvm-install/$WPIPREFIX/bin"
    CMAKE_ARGS+=(
        "-DCMAKE_C_COMPILER=${RECENT_CLANG_BUILD_TARGET_DIR}/clang"
        "-DCMAKE_C_COMPILER_TARGET=$TARGET_TUPLE"
        "-DCMAKE_CXX_COMPILER=${RECENT_CLANG_BUILD_TARGET_DIR}/clang++"
        "-DCMAKE_CXX_COMPILER_TARGET=$TARGET_TUPLE"
        "-DCMAKE_AR=${RECENT_CLANG_BUILD_TARGET_DIR}/llvm-ar"
    )
fi

cmake "$ROOT_DIR/downloads/llvm-toolchains/libcxx/" \
    -G Ninja "${CMAKE_ARGS[@]}"
ninja $NINJA_ARGS
DESTDIR="${BUILD_TARGET_DIR}/libcxx-install/$TARGET_TUPLE" ninja install

popd
