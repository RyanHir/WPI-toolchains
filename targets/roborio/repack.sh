#! /usr/bin/env bash

set -e
source "$(dirname "$0")/version.env" || exit
source "$SCRIPT_DIR/repack_tools.sh" || exit

WORK_DIR="$PWD"
REPACK_DIR="$1"

repack-ni
