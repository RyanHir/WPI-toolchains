#! /usr/bin/env bash

is-mac || return 0

PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH

SDK_PATH="/Library/Developer/CommandLineTools/SDKs"

CC="cc"
CXX="c++"
AR="ar"
LD="ld"
NM="nm"
RANLIB="ranlib"
LIPO="lipo"
OBJDUMP="objdump"

ls -l "$SDK_PATH"
[ -d "$SDK_PATH/MacOSX${WPI_HOST_SDK_CUR}.sdk" ] || exit

unset SDK_PATH

