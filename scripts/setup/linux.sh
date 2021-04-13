#! /usr/bin/env bash

is-linux || return 0

# CC="${WPIHOSTTARGET}-gcc"
# CXX="${WPIHOSTTARGET}-g++"
# CPP="${WPIHOSTTARGET}-cpp"
# LD="${WPIHOSTTARGET}-ld"
# export CC CXX CPP LD

CFLAGS=""
CXXFLAGS=""
if [ "$WPITARGET" = "Windows" ]; then
    CFLAGS="$CFLAGS -Wno-unused-command-line-argument"
    CXXFLAGS="$CXXFLAGS -Wno-unused-command-line-argument"
    LDFLAGS="$LDFLAGS -Wno-unused-command-line-argument"
    
else
    CFLAGS="$CFLAGS -fPIC"
    CXXFLAGS="$CXXFLAGS -fPIC"
fi
export CFLAGS CXXFLAGS LDFLAGS
