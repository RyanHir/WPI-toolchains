#! /usr/bin/env bash

set -e

rm -rf "${HOST_BUILD_DIR}/wrapper-"{build,install}
mkdir -p "${HOST_BUILD_DIR}/wrapper-build/"

CMAKE_ARGS=(
    "-DCMAKE_BUILD_TYPE=Debug"
    "-DCMAKE_INSTALL_PREFIX=${WPIPREFIX}"
    "-DLLVM_GCC_VERSION=$V_GCC"
)

if [ "$WPITARGET" = "Windows" ]; then
    EXE_SUFFIX=".exe"
    CMAKE_ARGS+=(
        "-DCMAKE_SYSTEM_NAME=Windows"
        "-DCMAKE_CROSSCOMPILING=TRUE"
        "-DCMAKE_C_COMPILER=$WPIHOSTTARGET-clang"
        "-DCMAKE_CXX_COMPILER=$WPIHOSTTARGET-clang++"
    )
fi

pushd "${HOST_BUILD_DIR}/wrapper-build/"
cmake "${ROOT_DIR}/res/wrapper/" \
    -GNinja "${CMAKE_ARGS[@]}"
ninja $NINJA_ARGS
DESTDIR="${HOST_BUILD_DIR}/wrapper-install/" ninja install
popd
