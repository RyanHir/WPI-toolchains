#! /usr/bin/env bash

is-mac || return 0

PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH

CMD_LINE_TOOLS="/Library/Developer/CommandLineTools"
OSX_SDK_PATH="${CMD_LINE_TOOLS}/SDKs"

PATH="${CMD_LINE_TOOLS}/usr/bin/:${PATH}"

CC="${CMD_LINE_TOOLS}/usr/bin/clang"
CXX="${CMD_LINE_TOOLS}/usr/bin/clang++"
AR="${CMD_LINE_TOOLS}/usr/bin/ar"
LD="${CMD_LINE_TOOLS}/usr/bin/ld"
NM="${CMD_LINE_TOOLS}/usr/bin/nm"
RANLIB="${CMD_LINE_TOOLS}/usr/bin/ranlib"
LIPO="${CMD_LINE_TOOLS}/usr/bin/lipo"
OBJDUMP="${CMD_LINE_TOOLS}/usr/bin/objdump"

ls -l "$OSX_SDK_PATH"
[ -d "$OSX_SDK_PATH/MacOSX.sdk" ] || {
    echo "[ERROR] Could not find SDK(s) in $OSX_SDK_PATH"
    exit 1
}
OSX_SDK_PATH+="/MacOSX.sdk"
unset CMD_LINE_TOOLS
