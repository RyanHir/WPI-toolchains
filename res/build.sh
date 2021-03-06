#! /usr/bin/env bash

TAGS=( "16.04" "20.04" )
BIN_PWD="$(dirname "$0")"

if ! [[ " ${TAGS[@]} " =~ " $TAG " ]]; then
    echo "Tag not found. Try one of these..."
    echo "${TAGS[@]}"
    exit 1
fi

DOCKERFILE=Dockerfile

pushd "$BIN_PWD"
docker build \
    --build-arg BASE="$TAG" \
    -t "wpilib/toolchain-builder:$TAG" \
    -f "$DOCKERFILE" \
    . || exit
popd
