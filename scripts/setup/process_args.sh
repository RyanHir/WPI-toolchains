#! /usr/bin/env bash

if [ "$#" != "3" ]; then
    exit 1
fi

HOST_CFG="$(readlink -f "$1")"
TARGET_CFG="$(readlink -f "$2")"
TARGET_PORT="$3"
TOOLCHAIN_NAME="$(basename "$TARGET_CFG")"

if ! [ -f "$HOST_CFG" ]; then
    echo "Cannot find selected host at $HOST_CFG"
    exit 1
fi

if ! [ -f "$TARGET_CFG/version.env" ]; then
    echo "$TARGET_CFG is not a supported toolchain"
    exit 1
fi

if ! grep -q "$TOOLCHAIN_NAME=$TARGET_PORT" "$ROOT_DIR/targets/ports.txt"; then
    echo "[ERR] $TARGET_PORT is not supported in $TOOLCHAIN_NAME"
    exit 1
fi

