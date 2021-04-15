#! /usr/bin/env bash

source "${HOST_CFG}"
source "${ROOT_DIR}/consts.env"

cat <<EOF
Host System Info
    OS: ${WPITARGET}
    Tuple: ${WPIHOSTTARGET}
    Prefix: ${WPIPREFIX}
EOF

SCRIPT_DIR="${ROOT_DIR}/scripts/"
PATCH_DIR="${ROOT_DIR}/patches/"
BUILD_HOST_DIR="${ROOT_DIR}/build/${WPITARGET}_${WPIHOSTTARGET}/"

if [ "$WPITARGET" = "Windows" ]; then
    MINGW_DIR="${ROOT_DIR}/downloads/llvm-mingw/"
    PATH="$PATH:$MINGW_DIR/bin/"
fi
