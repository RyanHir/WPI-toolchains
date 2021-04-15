#! /usr/bin/env bash

# Always ensure proper path
cd "$(dirname "$0")" || exit

set -a
ROOT_DIR="${PWD}"
source "$ROOT_DIR/scripts/setup.sh"
set +a
set -e

# Prep builds
pushd "${DOWNLOAD_DIR}"
bash "${SCRIPT_DIR}/prep_llvm.sh"
popd

MAKE="make -C ${ROOT_DIR}/makes/"
${MAKE} build-host

while read port; do
    [ -n "$port" ] || continue

    ${MAKE} \
        TARGET_OS="${port/=*/}" \
        TARGET_PORT="${port/*=/}" \
        build-target

    if is-mac-codesign; then
        bash scripts/codesign.sh
    fi
done <"$ROOT_DIR/targets/ports.txt"
