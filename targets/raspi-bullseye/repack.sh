#! /usr/bin/env bash

set -e
source "$(dirname "$0")/version.env" || exit
source "$SCRIPT_DIR/repack_tools.sh" || exit

REPACK_DIR="$1"

repack-debian
