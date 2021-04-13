#! /usr/bin/env bash

source "${HOST_CFG}"
source "${ROOT_DIR}/consts.env"
source "${TARGET_CFG}/info.${TARGET_PORT}.env"
source "${TARGET_CFG}/version.env"

cat <<EOF
Host System Info
    OS: ${WPITARGET}
    Tuple: ${WPIHOSTTARGET}
    Prefix: ${WPIPREFIX}
Toolchain Info:
    Name: ${TOOLCHAIN_NAME}
    libgcc: ${V_GCC}
    Vendor Tuple: ${TARGET_TUPLE}
    Prefered Tuple: ${TARGET_TUPLE_RENAME}
EOF

DOWNLOAD_DIR="${ROOT_DIR}/downloads/${TOOLCHAIN_NAME}-${TARGET_PORT}/"
REPACK_DIR="${ROOT_DIR}/repack/${TOOLCHAIN_NAME}-${TARGET_PORT}/"
SCRIPT_DIR="${ROOT_DIR}/scripts/"
PATCH_DIR="${ROOT_DIR}/patches/"
BUILD_DIR="${ROOT_DIR}/build/${TOOLCHAIN_NAME}-${TARGET_PORT}/${WPITARGET}/"

# PATH="$PATH:$BUILD_DIR/binutils-install/${WPIPREFIX}/bin/"
PATH="$PATH:$BUILD_DIR/gcc-install/${WPIPREFIX}/bin/"
PATH="$PATH:$DOWNLOAD_DIR/../llvm-mingw/bin/"
