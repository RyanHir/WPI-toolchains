#! /usr/bin/env bash

set -e
source "$SCRIPT_DIR/repack_tools.sh" || {
    echo "[ERROR] Could not source repack_tools.sh"
    false   
}

REPACK_DIR="$1"

repack-debian "$REPACK_DIR" "$DOWNLOAD_DIR" "$TARGET_TUPLE" "$V_GCC"
