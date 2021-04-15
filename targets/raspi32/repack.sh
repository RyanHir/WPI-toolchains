#! /usr/bin/env bash

set -e
source "$SCRIPT_DIR/repack_tools.sh" || exit

REPACK_DIR="$1"

repack-debian "$REPACK_DIR" "$DOWNLOAD_DIR" "$TARGET_TUPLE" "$V_GCC"
