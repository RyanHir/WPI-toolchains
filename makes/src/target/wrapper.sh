#! /usr/bin/env bash

set -e

rm -rf "${BUILD_TARGET_DIR}/wrapper-install"
mkdir -p "${BUILD_TARGET_DIR}/wrapper-build"

CMAKE_ARGS=(
    "-DCMAKE_BUILD_TYPE=MinSizeRel"
    "-DCMAKE_INSTALL_PREFIX=${WPIPREFIX}"
    "-DLLVM_GCC_VERSION=$V_GCC"
)

if [ "$WPITARGET" = "Windows" ]; then
    CMAKE_ARGS+=(
        "-DCMAKE_SYSTEM_NAME=Windows"
        "-DCMAKE_CROSSCOMPILING=TRUE"
        "-DCMAKE_C_COMPILER=$WPIHOSTTARGET-clang"
        "-DCMAKE_CXX_COMPILER=$WPIHOSTTARGET-clang++"
    )
elif [ "$WPITARGET" = "Mac" ]; then
    CMAKE_ARGS+=(
        "-DCMAKE_OSX_ARCHITECTURES=${WPI_HOST_SDK_TARGET}"
        "-DCMAKE_OSX_DEPLOYMENT_TARGET=${WPI_HOST_SDK_MIN}"
    )
fi

pushd "${BUILD_TARGET_DIR}/wrapper-build/"
cmake "${ROOT_DIR}/res/wrapper/" \
    -GNinja "${CMAKE_ARGS[@]}"
ninja $NINJA_ARGS
DESTDIR="${BUILD_TARGET_DIR}/wrapper-install/" ninja install
popd
