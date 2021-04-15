#! /usr/bin/env bash

is-actions && JOBS="6" # Use the same across all actions
is-actions && NINJA_ARGS="-j $JOBS"
