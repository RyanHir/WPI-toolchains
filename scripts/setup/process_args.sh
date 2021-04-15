#! /usr/bin/env bash

HOST_CFG="$(readlink -f "$1")"
if ! [ -f "$HOST_CFG" ]; then
    echo "Cannot find selected host at $HOST_CFG"
    exit 1
fi
