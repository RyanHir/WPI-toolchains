#! /usr/bin/env bash

sign_directory()
{
    find "$1" | while read fname; do
        if [[ -f "$fname" ]]; then
            echo "[INFO] Signing $fname"
            codesign --force --strict --timestamp --options=runtime -s "$APPLE_DEVELOPER_ID" "$fname"
        fi
    done
}

set -e

cd "$BUILD_DIR/tree-install/frc${V_YEAR}/${TOOLCHAIN_NAME}/"
sign_directory "./bin"
sign_directory "./${TARGET_PREFIX}/bin"
sign_directory "./libexec/gcc/${TARGET_PREFIX}/${V_GCC}"
