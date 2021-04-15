#! /usr/bin/env bash

is-mac || return 0

PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH

OSX_SDK_PATH="/Library/Developer/CommandLineTools/SDKs"

CC="cc"
CXX="c++"
AR="ar"
LD="ld"
NM="nm"
RANLIB="ranlib"
LIPO="lipo"
OBJDUMP="objdump"

ls -l "$OSX_SDK_PATH"
[ -d "$OSX_SDK_PATH/MacOSX.sdk" ] || {
    echo "[ERROR] Could not find SDK(s) in $OSX_SDK_PATH"
    exit 1
}
OSX_SDK_PATH+="MacOSX.sdk"
