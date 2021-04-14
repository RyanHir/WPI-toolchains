#! /usr/bin/env bash

# Make-server processes
JOBS="$(nproc --ignore=1)"
is-actions && JOBS="6" # Use the same across all actions
NINJA_ARGS="-j $JOBS"
