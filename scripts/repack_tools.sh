#! /usr/bin/env bash

[ -n "${V_GCC+x}" ] || exit
[ -n "${REPACK_DIR+x}" ] || exit
[ -n "${DOWNLOAD_DIR+x}" ] || exit
[ -n "${TARGET_TUPLE+x}" ] || exit
[ -n "${TARGET_PREFIX+x}" ] || exit

# TODO: Convert to python in librepack
function fix-links() {
    pushd "${DOWNLOAD_DIR}/sysroot-libc-linux/"
    for symlink in $(find ./ -name "*.*" -type l); do
        source="$(readlink $symlink | sed "s/${TARGET_TUPLE}/${TARGET_PREFIX}/g")"
        echo "$symlink -> $source"
        pushd "$(dirname "$symlink")" >/dev/null
        f_name="$(basename "$symlink")"
        if [ -e "$source" ]; then
            rm "$f_name"
            cp "$source" "$f_name"
        elif [ -e "$DOWNLOAD_DIR/sysroot-libc-linux/$source" ]; then
            rm "$f_name"
            cp "$DOWNLOAD_DIR/sysroot-libc-linux/$source" "$f_name"
        else
            echo "$source: not valid link, potentially missing dep."
            exit 1
        fi
        popd >/dev/null
    done
    popd
}

function repack-debian() {
    rm -rf "${REPACK_DIR}"
    mkdir -p "${REPACK_DIR}"
    cp *.deb "${REPACK_DIR}"

    python3 -B "${SCRIPT_DIR}/repackcli.py" \
        --repackdir="$REPACK_DIR" \
        --downloaddir="$DOWNLOAD_DIR" \
        --gccver="$V_GCC" \
        --tuple="$TARGET_TUPLE" \
        --rename_tuple="$TARGET_PREFIX"
    fix-links
}

function repack-ni() {
    rm -rf "${REPACK_DIR}"
    mkdir -p "${REPACK_DIR}"
    cp *.ipk "${REPACK_DIR}"

    python3 -B "${SCRIPT_DIR}/repackcli.py" \
        --repackdir="$REPACK_DIR" \
        --downloaddir="$DOWNLOAD_DIR" \
        --gccver="$V_GCC" \
        --tuple="$TARGET_TUPLE" \
        --rename_tuple="$TARGET_PREFIX"
    fix-links
}
